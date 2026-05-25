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

class _CustomerDirectoryContent extends StatelessWidget {
  const _CustomerDirectoryContent();

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
