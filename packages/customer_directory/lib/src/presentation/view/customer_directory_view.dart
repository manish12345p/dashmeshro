import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:core_ui/core_ui.dart';

import '../../domain/repositories/customer_repository_interface.dart';
import '../../data/repositories/customer_repository.dart';
import '../../domain/use_cases/get_customers_usecase.dart';
import '../bloc/customer_directory_bloc.dart';
import '../bloc/customer_directory_event.dart';
import '../bloc/customer_directory_state.dart';
import '../../domain/entities/customer.dart';
import '../widgets/customer_card.dart';
import '../widgets/allocation_card.dart';

class CustomerDirectoryView extends StatelessWidget {
  final CustomerDirectoryBloc? bloc;
  final ICustomerRepository? repository;

  const CustomerDirectoryView({super.key, this.bloc, this.repository});

  @override
  Widget build(BuildContext context) {
    final repo = repository ?? CustomerRepository();

    return BlocProvider(
      create: (context) => bloc ?? CustomerDirectoryBloc(
        getCustomersUseCase: GetCustomersUseCase(repo),
      )..add(const LoadCustomers()),
      child: const Scaffold(
        backgroundColor: Color(0xFFF8FAFC),
        body: _CustomerDirectoryContent(),
      ),
    );
  }
}

class _CustomerDirectoryContent extends StatefulWidget {
  const _CustomerDirectoryContent();

  @override
  State<_CustomerDirectoryContent> createState() => _CustomerDirectoryContentState();
}

class _CustomerDirectoryContentState extends State<_CustomerDirectoryContent> {
  String _selectedFilter = 'All';

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final filters = ['All', 'Active', 'Inactive', 'Premium', 'Overdue'];
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle bar
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Title
                  Row(
                    children: [
                      const Icon(Icons.tune_rounded, color: Color(0xFF0D2137), size: 22),
                      const SizedBox(width: 10),
                      Text(
                        'Filter Customers',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Filter chips
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: filters.map((filter) {
                      final isSelected = _selectedFilter == filter;
                      return GestureDetector(
                        onTap: () {
                          setModalState(() {});
                          setState(() {
                            _selectedFilter = filter;
                          });
                          // Apply filter via bloc if needed
                          if (filter == 'All') {
                            context.read<CustomerDirectoryBloc>().add(const SearchCustomers(''));
                          } else {
                            context.read<CustomerDirectoryBloc>().add(SearchCustomers(filter));
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? const LinearGradient(
                                    colors: [Color(0xFF0D2137), Color(0xFF1A3A5C)],
                                  )
                                : null,
                            color: isSelected ? null : const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? Colors.transparent : const Color(0xFFE2E8F0),
                            ),
                          ),
                          child: Text(
                            filter,
                            style: TextStyle(
                              color: isSelected ? Colors.white : const Color(0xFF475569),
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  // Apply button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D2137),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Apply Filter',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BlocBuilder<CustomerDirectoryBloc, CustomerDirectoryState>(
        builder: (context, state) {
          if (state is CustomerDirectoryLoading || state is CustomerDirectoryInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CustomerDirectoryError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          if (state is CustomerDirectoryLoaded) {
            final customers = state.filteredCustomers;
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppPadding.p16,
                AppPadding.p16,
                AppPadding.p16,
                AppPadding.p48 + 80,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Bar Area
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.menu, color: Color(0xFF64748B)),
                        onPressed: () {},
                      ),
                      Text(
                        'Dashmesh Mechanix',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.1,
                              color: const Color(0xFF1E293B),
                            ),
                      ),
                      const CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=150',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppPadding.p24),

                  // Header Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Customer\nDirectory',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0F172A),
                              height: 1.15,
                            ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF0D2137), Color(0xFF1A3A5C)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF0D2137).withOpacity(0.35),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () {
                              // TODO: Navigate to add customer
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(12),
                              child: Icon(
                                Icons.add_rounded,
                                color: Colors.white,
                                size: 26,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppPadding.p8),
                  Text(
                    'Manage your client relationships with mechanical precision and fluid clarity.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF475569),
                        ),
                  ),
                  const SizedBox(height: AppPadding.p24),

                  // Search Bar
                  TextField(
                    onChanged: (val) {
                      context.read<CustomerDirectoryBloc>().add(SearchCustomers(val));
                    },
                    decoration: InputDecoration(
                      hintText: 'Search by name, status or company',
                      prefixIcon: const Icon(Icons.search, color: Color(0xFF64748B)),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: AppPadding.p12,
                        horizontal: AppPadding.p16,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  const SizedBox(height: AppPadding.p16),

                  // Filter & New Client buttons
                  Row(
                    children: [
                      // Filter button
                      OutlinedButton.icon(
                        onPressed: () {
                          _showFilterBottomSheet(context);
                        },
                        icon: const Icon(
                          Icons.tune_rounded,
                          size: 18,
                          color: Color(0xFF334155),
                        ),
                        label: const Text(
                          'Filter',
                          style: TextStyle(
                            color: Color(0xFF334155),
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          side: const BorderSide(color: Color(0xFFCBD5E1)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // New Client button
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF0D2137), Color(0xFF1A3A5C)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF0D2137).withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                // TODO: Navigate to add new client
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_rounded, color: Colors.white, size: 20),
                                    SizedBox(width: 6),
                                    Text(
                                      'New Client',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppPadding.p24),

                  // Customer List
                  ...customers.map((customer) => CustomerCard(customer: customer)),
                  const SizedBox(height: AppPadding.p24),

                  // Fleet Resource Allocation
                  const AllocationCard(),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
