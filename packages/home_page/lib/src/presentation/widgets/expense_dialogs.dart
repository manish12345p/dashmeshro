import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:core_ui/core_ui.dart';
import '../../data/remote/note_firestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ADD NOTE DIALOG (shown from FAB)
// ─────────────────────────────────────────────────────────────────────────────

class AddNoteDialog extends StatefulWidget {
  final NoteModel? noteToEdit;
  const AddNoteDialog({super.key, this.noteToEdit});

  static Future<void> show(BuildContext context, {NoteModel? note}) async {
    await showDialog(
      context: context,
      builder: (_) => AddNoteDialog(noteToEdit: note),
    );
  }

  @override
  State<AddNoteDialog> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _noteController = TextEditingController();
  final _priceController = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    if (widget.noteToEdit != null) {
      final note = widget.noteToEdit!;
      _nameController.text = note.name == 'not provided' ? '' : note.name;
      _phoneController.text = note.phone == 'not provided' ? '' : note.phone;
      _addressController.text = note.address == 'not provided' ? '' : note.address;
      _noteController.text = note.note == 'not provided' ? '' : note.note;
      _priceController.text = note.price != null && note.price! > 0 ? note.price!.toStringAsFixed(0) : '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _noteController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.surfaceSecondary,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: context.colors.border),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Header ────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Row(
                children: [
                  Icon(Icons.note_add_rounded, color: context.colors.primary, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.noteToEdit != null ? 'Edit Estimate' : AppStrings.addNote,
                      style: TextStyle(
                        color: context.colors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close_rounded,
                          color: context.colors.textSecondary, size: 20),
                    ),
                  ),
                ],
              ),
            ),

            // ── Form ──────────────────────────────────────────────────────
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildField(
                        context: context,
                        controller: _nameController,
                        label: AppStrings.nameLabel,
                        hint: AppStrings.nameHint,
                        icon: Icons.person_rounded,
                        capitalization: TextCapitalization.words,
                        validator: null,
                      ),
                      const SizedBox(height: 20),
                      _buildField(
                        context: context,
                        controller: _phoneController,
                        label: AppStrings.phoneLabel,
                        hint: AppStrings.phoneHint,
                        icon: Icons.phone_rounded,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        validator: null,
                      ),
                      const SizedBox(height: 20),
                      _buildField(
                        context: context,
                        controller: _addressController,
                        label: AppStrings.addressLabel,
                        hint: AppStrings.addressHint,
                        icon: Icons.location_on_rounded,
                        maxLines: 2,
                        validator: null,
                      ),
                      const SizedBox(height: 20),
                      _buildField(
                        context: context,
                        controller: _noteController,
                        label: AppStrings.noteLabel,
                        hint: AppStrings.noteHint,
                        icon: Icons.notes_rounded,
                        maxLines: 3,
                        validator: null,
                      ),
                      const SizedBox(height: 20),
                      _buildField(
                        context: context,
                        controller: _priceController,
                        label: AppStrings.priceLabel,
                        hint: AppStrings.priceHint,
                        icon: Icons.currency_rupee_rounded,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        // price is optional
                      ),
                      const SizedBox(height: 32),
                      // Buttons
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                foregroundColor: context.colors.textSecondary,
                              ),
                              child: const Text(
                                AppStrings.cancel,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _saving ? null : _save,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: context.colors.primary,
                                foregroundColor: context.colors.surface,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: _saving
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: context.colors.surface,
                                      ),
                                    )
                                  : const Text(
                                      AppStrings.save,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextCapitalization capitalization = TextCapitalization.none,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: context.colors.textSecondary,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          textCapitalization: capitalization,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: context.colors.textTertiary, fontSize: 14),
            prefixIcon: Icon(icon, color: context.colors.textTertiary, size: 20),
            filled: true,
            fillColor: context.colors.surface,
            contentPadding: EdgeInsets.symmetric(
              vertical: maxLines > 1 ? 14 : 0,
              horizontal: 0,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: context.colors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: context.colors.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: context.colors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: context.colors.error, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _save() async {
    // Form validation is no longer required since fields are optional
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _saving = true);

    final priceText = _priceController.text.trim();
    final price = priceText.isEmpty ? 0.0 : double.tryParse(priceText) ?? 0.0;

    final nameText = _nameController.text.trim();
    final phoneText = _phoneController.text.trim();
    final addressText = _addressController.text.trim();
    final noteText = _noteController.text.trim();

    try {
      final data = {
        'name': nameText.isEmpty ? 'not provided' : nameText,
        'phone': phoneText.isEmpty ? 'not provided' : phoneText,
        'address': addressText.isEmpty ? 'not provided' : addressText,
        'note': noteText.isEmpty ? 'not provided' : noteText,
        'price': price,
        'created_at': widget.noteToEdit != null ? widget.noteToEdit!.createdAt.toIso8601String() : DateTime.now().toIso8601String(),
      };

      if (widget.noteToEdit != null && widget.noteToEdit!.id != null) {
        await Supabase.instance.client.from('estimates').update(data).eq('id', widget.noteToEdit!.id!);
      } else {
        await Supabase.instance.client.from('estimates').insert(data);
      }

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.successNoteSaved)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving estimate: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// VIEW NOTES DIALOG (shown from the document icon in the app bar)
// ─────────────────────────────────────────────────────────────────────────────

class ViewNotesDialog extends StatefulWidget {
  const ViewNotesDialog({super.key});

  static Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => const ViewNotesDialog(),
    );
  }

  @override
  State<ViewNotesDialog> createState() => _ViewNotesDialogState();
}

class _ViewNotesDialogState extends State<ViewNotesDialog> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Header ────────────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(color: context.colors.primary),
              child: Row(
                children: [
                  const Icon(Icons.sticky_note_2, color: Colors.white, size: 22),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      AppStrings.allNotes,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white70, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

            // ── Search Bar ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search estimates...',
                  prefixIcon: Icon(Icons.search, color: context.colors.textSecondary),
                  filled: true,
                  fillColor: context.colors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: context.colors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: context.colors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: context.colors.primary),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),

            // ── Body ──────────────────────────────────────────────────────
            Flexible(
              child: StreamBuilder<List<NoteModel>>(
                stream: NoteFirestore.watchNotes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(40),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(32),
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
                    return Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.note_alt_outlined,
                            size: 56,
                            color: context.colors.border,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            AppStrings.noNotes,
                            style: TextStyle(
                              color: context.colors.textSecondary,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            AppStrings.noNotesSubtitle,
                            style: TextStyle(
                              color: context.colors.textTertiary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 520),
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 16),
                      itemCount: notes.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                      ),
                      itemBuilder: (context, index) {
                        final n = notes[index];
                        return _NoteCard(note: n);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// NOTE CARD ITEM
// ─────────────────────────────────────────────────────────────────────────────

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
        color: Colors.red.shade400,
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 24),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Delete Note'),
            content:
                Text('Delete note for "${note.name}"? This cannot be undone.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade400),
                child: const Text('Delete',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) async {
        if (note.id != null) await NoteFirestore.deleteNote(note.id!);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Row 1: Name + price ───────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: Text(
                    note.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                if (note.price != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 3),
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
            const SizedBox(height: 4),
            // ── Row 2: Phone ─────────────────────────────────────────────
            Row(
              children: [
                Icon(Icons.phone, size: 13,
                    color: context.colors.textSecondary),
                const SizedBox(width: 4),
                Text(
                  note.phone,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            // ── Row 3: Address ───────────────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on, size: 13,
                    color: context.colors.textSecondary),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    note.address,
                    style: TextStyle(
                      fontSize: 12,
                      color: context.colors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            // ── Note text ────────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: context.colors.surfaceSecondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                note.note,
                style: const TextStyle(fontSize: 13),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                dateStr,
                style: TextStyle(
                  fontSize: 11,
                  color: context.colors.textTertiary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Keep old class names as aliases so home_page_view.dart still compiles
// until we update it
// ─────────────────────────────────────────────────────────────────────────────

/// @deprecated Use [AddNoteDialog] instead
typedef AddExpenseDialog = AddNoteDialog;

/// @deprecated Use [ViewNotesDialog] instead
typedef ViewExpensesDialog = ViewNotesDialog;
