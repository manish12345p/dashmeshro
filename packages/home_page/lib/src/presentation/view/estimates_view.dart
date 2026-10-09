import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';
import '../../data/remote/note_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/expense_dialogs.dart';

class EstimatesView extends StatefulWidget {
  const EstimatesView({super.key});

  @override
  State<EstimatesView> createState() => _EstimatesViewState();
}

class _EstimatesViewState extends State<EstimatesView> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  late final Stream<List<NoteModel>> _estimatesStream;

  @override
  void initState() {
    super.initState();
    _estimatesStream = Supabase.instance.client
        .from('estimates')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((list) => list.map((e) => NoteModel.fromMap(e['id'] as String, e)).toList());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estimates', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: context.colors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      backgroundColor: context.colors.surfaceSecondary,
      body: Column(
        children: [
          // ── Search Bar ────────────────────────────────────────────────
          Container(
            color: context.colors.primary,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
              controller: _searchController,
              onChanged: (val) {
                setState(() {
                  _searchQuery = val.toLowerCase();
                });
              },
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                hintText: 'Search estimates...',
                prefixIcon: Icon(Icons.search, color: context.colors.textSecondary),
                filled: true,
                fillColor: context.colors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),

          // ── Body ──────────────────────────────────────────────────────
          Expanded(
            child: StreamBuilder<List<NoteModel>>(
              stream: _estimatesStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error loading notes',
                      style: TextStyle(color: context.colors.textSecondary),
                    ),
                  );
                }

                final allNotes = snapshot.data ?? [];
                
                final notes = allNotes.where((n) {
                  if (_searchQuery.isEmpty) return true;
                  final searchStr = '${n.name} ${n.phone} ${n.address} ${n.note}'.toLowerCase();
                  return searchStr.contains(_searchQuery);
                }).toList();

                if (notes.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.note_alt_outlined,
                          size: 64,
                          color: context.colors.border,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppStrings.noNotes,
                          style: TextStyle(
                            color: context.colors.textSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppStrings.noNotesSubtitle,
                          style: TextStyle(
                            color: context.colors.textTertiary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: notes.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final n = notes[index];
                    return _NoteCard(note: n);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  final NoteModel note;

  const _NoteCard({required this.note});

  @override
  Widget build(BuildContext context) {
    final primary = context.colors.primary;
    final daysAgo = DateTime.now().difference(note.createdAt).inDays;
    final dateStr = daysAgo == 0
        ? 'Today'
        : daysAgo == 1
            ? 'Yesterday'
            : '${note.createdAt.day}/${note.createdAt.month}/${note.createdAt.year}';

    return Dismissible(
      key: Key(note.id ?? note.phone),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Delete Estimate'),
            content: Text('Delete estimate for "${note.name}"? This cannot be undone.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade400),
                child: const Text('Delete', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) async {
        if (note.id != null) {
          try {
            await Supabase.instance.client.from('estimates').delete().eq('id', note.id!);
          } catch (_) {}
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.colors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    note.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                if (note.price != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '₹${note.price!.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.phone, size: 14, color: context.colors.textSecondary),
                const SizedBox(width: 6),
                Text(
                  note.phone,
                  style: TextStyle(
                    fontSize: 13,
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on, size: 14, color: context.colors.textSecondary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    note.address,
                    style: TextStyle(
                      fontSize: 13,
                      color: context.colors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.colors.surfaceSecondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                note.note,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                if (note.phone.isNotEmpty && note.phone.toLowerCase() != 'not provided')
                  TextButton.icon(
                    onPressed: () {
                      PhoneActionHandler.handleAction(
                        context: context,
                        rawNumbers: note.phone,
                        actionName: 'Call',
                        onSelected: (selectedNumber) async {
                          final url = Uri.parse('tel:$selectedNumber');
                          try {
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              await launchUrl(url);
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Could not launch dialer')),
                              );
                            }
                          }
                        },
                      );
                    },
                    icon: Icon(Icons.call, size: 16, color: context.colors.success),
                    label: Text('Call', style: TextStyle(color: context.colors.success)),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                const Spacer(),
                Text(
                  dateStr,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.colors.textTertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: () => AddNoteDialog.show(context, note: note),
                  icon: const Icon(Icons.edit, size: 20),
                  color: context.colors.primary,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Delete Estimate'),
                        content: Text('Delete estimate for "${note.name}"? This cannot be undone.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade400),
                            child: const Text('Delete', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true && note.id != null) {
                      try {
                        await Supabase.instance.client.from('estimates').delete().eq('id', note.id!);
                      } catch (_) {}
                    }
                  },
                  icon: const Icon(Icons.delete_outline, size: 20),
                  color: Colors.red.shade400,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
