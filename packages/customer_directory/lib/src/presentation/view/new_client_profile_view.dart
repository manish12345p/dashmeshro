import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/new_client_header_bar.dart';
import '../widgets/new_client_form_card.dart';
import '../widgets/new_client_action_buttons.dart';
import '../widgets/new_client_info_cards.dart';

class NewClientProfileView extends StatefulWidget {
  const NewClientProfileView({super.key});

  @override
  State<NewClientProfileView> createState() => _NewClientProfileViewState();
}

class _NewClientProfileViewState extends State<NewClientProfileView> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _localityController = TextEditingController();
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _localityController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const NewClientHeaderBar(),
              const SizedBox(height: 28),

              // Title
              Text(
                'New Client Profile',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0F172A),
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                'Initialize a new relationship with premium detail.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF64748B),
                    ),
              ),
              const SizedBox(height: 28),

              // Form
              NewClientFormCard(
                nameController: _nameController,
                phoneController: _phoneController,
                localityController: _localityController,
                addressController: _addressController,
                notesController: _notesController,
              ),
              const SizedBox(height: 28),

              // Action Buttons
              NewClientActionButtons(
                onSave: () {
                  // TODO: Save client logic
                  Navigator.of(context).pop();
                },
                onSaveAndCreateEntry: () {
                  // TODO: Save client logic first
                  context.go('/service');
                },
              ),
              const SizedBox(height: 28),

              // Info Cards
              const NewClientInfoCards(),
            ],
          ),
        ),
      ),
    );
  }
}
