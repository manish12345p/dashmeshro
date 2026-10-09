import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/new_client_header_bar.dart';
import '../widgets/new_client_form_card.dart';
import '../widgets/new_client_action_buttons.dart';
import '../widgets/ro_type_dropdown.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/customer.dart';
import '../bloc/new_customer_bloc.dart';
import '../../domain/repositories/customer_repository_interface.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';

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
  String _roType = '';

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _localityController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  /// Generate a unique customer ID in UUID v4 format
  String _generateCustomerId() {
    final rng = Random();
    String generate(int length) {
      final chars = '0123456789abcdef';
      return List.generate(length, (_) => chars[rng.nextInt(chars.length)]).join();
    }
    return '${generate(8)}-${generate(4)}-4${generate(3)}-a${generate(3)}-${generate(12)}';
  }

  void _showSuccessPopup(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 60,
        left: 24,
        right: 24,
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 300),
            builder: (context, value, child) => Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, -20 * (1 - value)),
                child: child,
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [context.colors.primaryDark, context.colors.primary],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: context.colors.primaryDark.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: context.colors.success.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: context.colors.success,
                      size: 22,
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    Future.delayed(const Duration(seconds: 2), () {
      entry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewCustomerBloc(sl<ICustomerRepository>()),
      child: BlocListener<NewCustomerBloc, NewCustomerState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (docId, customerName, navigateToService) {
              _showSuccessPopup(
                context,
                'Customer "$customerName" saved successfully!',
              );
              if (navigateToService) {
                Future.delayed(const Duration(seconds: 2), () {
                  if (context.mounted) {
                    context.go(
                      '/service',
                      extra: {
                        'showBackButton': true,
                        'customerId': docId,
                        'customerName': customerName,
                      },
                    );
                  }
                });
              } else {
                Future.delayed(const Duration(seconds: 2), () {
                  if (context.mounted) {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/customers');
                    }
                  }
                });
              }
            },
            failure: (message) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Error: $message')));
            },
            orElse: () {},
          );
        },
        child: Scaffold(
          backgroundColor: context.colors.background,
          body: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  const NewClientHeaderBar(),
                  SizedBox(height: 28),

                  // Title
                  Text(
                    'New Client Profile',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: context.colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Initialize a new relationship with premium detail.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: context.colors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 28),

                  // Form
                  NewClientFormCard(
                    nameController: _nameController,
                    phoneController: _phoneController,
                    localityController: _localityController,
                    addressController: _addressController,
                    notesController: _notesController,
                  ),
                  SizedBox(height: 20),

                  RoTypeDropdownWidget(
                    initialValue: _roType,
                    onChanged: (val) {
                      setState(() {
                        _roType = val;
                      });
                    },
                  ),
                  SizedBox(height: 24),



                  // Action Buttons
                  BlocBuilder<NewCustomerBloc, NewCustomerState>(
                    builder: (context, state) {
                      final isSubmitting = state.maybeWhen(
                        submitting: () => true,
                        orElse: () => false,
                      );

                      if (isSubmitting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      return NewClientActionButtons(
                        onSave: () {
                          _submitForm(context, false);
                        },
                        onSaveAndCreateEntry: () {
                          _submitForm(context, true);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm(BuildContext context, bool navigateToService) {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final locality = _localityController.text.trim();
    final address = _addressController.text.trim();
    final notes = _notesController.text.trim();

    if (name.isEmpty && phone.isEmpty && locality.isEmpty && address.isEmpty && notes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter at least one detail to save')),
      );
      return;
    }

    final customerId = _generateCustomerId();

    final finalName = name.isEmpty ? 'Unknown' : name;
    final finalPhone = phone; // leave empty if empty for duplicate checks
    final finalLocality = locality.isEmpty ? 'Not provided' : locality;
    final finalAddress = address.isEmpty ? 'Not provided' : address;
    final finalNotes = notes.isEmpty ? 'Not provided' : notes;
    final finalRoType = _roType.isEmpty ? 'Not provided' : _roType;

    final newCustomer = Customer(
      id: '',
      name: finalName,
      customerId: customerId,
      number: finalPhone,
      address: finalAddress,
      locality: finalLocality,
      roType: finalRoType,
      note: finalNotes,
    );

    context.read<NewCustomerBloc>().add(
      NewCustomerEvent.submit(
        customer: newCustomer,
        navigateToService: navigateToService,
      ),
    );
  }
}
