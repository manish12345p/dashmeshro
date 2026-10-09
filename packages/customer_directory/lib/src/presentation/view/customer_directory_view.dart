import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:core_ui/core_ui.dart';
import 'package:core/core.dart'; // import role cubit

import '../../domain/repositories/customer_repository_interface.dart';
import '../../data/repositories/customer_repository.dart';
import '../../domain/use_cases/get_customers_usecase.dart';
import '../bloc/customer_directory_bloc.dart';
import '../bloc/customer_directory_event.dart';
import '../bloc/customer_directory_state.dart';
import '../../domain/entities/customer.dart';
import '../widgets/customer_card.dart';

class CustomerDirectoryView extends StatelessWidget {
  final CustomerDirectoryBloc? bloc;
  final ICustomerRepository? repository;

  const CustomerDirectoryView({super.key, this.bloc, this.repository});

  @override
  Widget build(BuildContext context) {
    final repo = repository ?? GetIt.instance<ICustomerRepository>();

    return BlocProvider(
      create: (context) =>
          bloc ??
                CustomerDirectoryBloc(
                  getCustomersUseCase: GetCustomersUseCase(repo),
                )
            ..add(const LoadCustomers()),
      child: Scaffold(
        backgroundColor: context.colors.background,
        appBar: AppBar(
          backgroundColor: context.colors.background,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            'Dashmesh Mechanix',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              letterSpacing: 1.1,
              color: context.colors.textPrimary,
              fontSize: 16,
            ),
          ),
          centerTitle: true,
          actions: const [],
        ),
        body: const _CustomerDirectoryContent(),
      ),
    );
  }
}

class _CustomerDirectoryContent extends StatefulWidget {
  const _CustomerDirectoryContent();

  @override
  State<_CustomerDirectoryContent> createState() =>
      _CustomerDirectoryContentState();
}

class _CustomerDirectoryContentState extends State<_CustomerDirectoryContent> {
  String _selectedFilter = 'All';
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BlocBuilder<CustomerDirectoryBloc, CustomerDirectoryState>(
        builder: (context, state) {
          if (state is CustomerDirectoryLoading ||
              state is CustomerDirectoryInitial) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is CustomerDirectoryError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          if (state is CustomerDirectoryLoaded) {
            final customers = state.filteredCustomers;
            
            int displayCount = customers.length;
            bool showViewAllButton = false;
            
            if (!_showAll && customers.length > 5) {
              displayCount = 5;
              showViewAllButton = true;
            }

            return Padding(
              padding: EdgeInsets.fromLTRB(
                AppPadding.p16,
                AppPadding.p16,
                AppPadding.p16,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Customer\nDirectory',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.colors.textPrimary,
                                height: 1.15,
                              ),
                        ),
                      ),
                      if (context.read<RoleCubit>().state == AppRole.admin)
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                context.colors.primaryDark,
                                context.colors.primary,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: context.colors.primaryDark.withOpacity(0.35),
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
                                context.push('/customers/new');
                              },
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Icon(
                                  Icons.add_rounded,
                                  color: context.colors.surface,
                                  size: 26,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: AppPadding.p8),
                  Text(
                    'Manage your client relationships with mechanical precision and fluid clarity.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: context.colors.textSecondary,
                    ),
                  ),
                  SizedBox(height: AppPadding.p24),

                  // Search Bar
                  TextField(
                    onChanged: (val) {
                      setState(() {
                        // Reset to show 5 when searching
                        _showAll = false;
                      });
                      context.read<CustomerDirectoryBloc>().add(
                        SearchCustomers(val),
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'Search by name, status or company',
                      prefixIcon: Icon(
                        Icons.search,
                        color: context.colors.textSecondary,
                      ),
                      filled: true,
                      fillColor: context.colors.surface,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: AppPadding.p12,
                        horizontal: AppPadding.p16,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: context.colors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppPadding.p16),

                  // Customer List
                  Expanded(
                    child: customers.isEmpty
                        ? Center(
                            child: Text(
                              'No data found',
                              style: TextStyle(
                                color: context.colors.textTertiary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.only(bottom: AppPadding.p48 + 80),
                            itemCount: displayCount + (showViewAllButton ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == displayCount && showViewAllButton) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _showAll = true;
                                      });
                                    },
                                    child: Text(
                                      'View All (${customers.length})',
                                      style: TextStyle(
                                        color: context.colors.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return CustomerCard(customer: customers[index]);
                            },
                          ),
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}

