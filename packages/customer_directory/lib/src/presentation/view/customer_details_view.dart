import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:core_ui/core_ui.dart';

import '../../domain/repositories/customer_repository_interface.dart';
import '../../data/repositories/customer_repository.dart';
import '../../domain/use_cases/get_customer_by_id_usecase.dart';
import '../bloc/customer_details_bloc.dart';
import '../bloc/customer_details_event.dart';
import '../bloc/customer_details_state.dart';
import '../../domain/entities/customer.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/device_card.dart';
import '../widgets/stats_grid.dart';
import '../widgets/activity_card.dart';

class CustomerDetailsView extends StatelessWidget {
  final String customerId;
  final CustomerDetailsBloc? bloc;
  final ICustomerRepository? repository;

  const CustomerDetailsView({
    super.key,
    required this.customerId,
    this.bloc,
    this.repository,
  });

  @override
  Widget build(BuildContext context) {
    final repo = repository ?? CustomerRepository();

    return BlocProvider(
      create: (context) => bloc ?? CustomerDetailsBloc(
        getCustomerByIdUseCase: GetCustomerByIdUseCase(repo),
      )..add(LoadCustomerDetails(customerId)),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
            onPressed: () {
              context.pop();
            },
          ),
          title: const Text(
            'Dashmesh Mechanix',
            style: TextStyle(
              color: Color(0xFF1E293B),
              fontWeight: FontWeight.w900,
              fontSize: 16,
              letterSpacing: 1.1,
            ),
          ),
          actions: [
            IconButton(
              icon: const CircleAvatar(
                radius: 14,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=150',
                ),
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: const _CustomerDetailsContent(),
      ),
    );
  }
}

class _CustomerDetailsContent extends StatelessWidget {
  const _CustomerDetailsContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerDetailsBloc, CustomerDetailsState>(
      builder: (context, state) {
        if (state is CustomerDetailsLoading || state is CustomerDetailsInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CustomerDetailsError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        if (state is CustomerDetailsLoaded) {
          final customer = state.customer;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header Card
                ProfileHeaderCard(customer: customer),
                const SizedBox(height: AppPadding.p16),

                // Registered Device Card
                DeviceCard(customer: customer),
                const SizedBox(height: AppPadding.p16),

                // Schedule service button
                _buildScheduleServiceButton(context),
                const SizedBox(height: AppPadding.p16),

                // Stats Grid
                StatsGrid(customer: customer),
                const SizedBox(height: AppPadding.p24),

                // Service History
                _buildServiceHistorySection(context, customer),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildScheduleServiceButton(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_month, color: Color(0xFF1E3A8A)),
              const SizedBox(width: 8),
              Text(
                'Schedule New Service',
                style: TextStyle(
                  color: Color(0xFF1E3A8A),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceHistorySection(BuildContext context, Customer customer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Service History',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  child: const Text('Export PDF', style: TextStyle(fontSize: 11, color: Color(0xFF1E3A8A))),
                ),
                const SizedBox(width: 6),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  child: const Text('Filters', style: TextStyle(fontSize: 11, color: Color(0xFF1E3A8A))),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        // List of Activities
        ...customer.serviceHistory.map((activity) => ActivityCard(activity: activity)),

        const SizedBox(height: 16),
        Center(
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFEFF6FF),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text(
              'VIEW ALL ACTIVITIES',
              style: TextStyle(color: Color(0xFF1E3A8A), fontWeight: FontWeight.bold, fontSize: 11),
            ),
          ),
        ),
      ],
    );
  }
}
