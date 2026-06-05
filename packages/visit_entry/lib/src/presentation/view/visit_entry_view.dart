import 'package:flutter/material.dart';
import '../widgets/customer_selector.dart';
import '../widgets/visit_type_selector.dart';
import '../widgets/visit_details_card.dart';
import '../widgets/remarks_date_selector.dart';
import '../widgets/action_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/visit_entry_bloc.dart';
import '../../domain/use_cases/save_visit_usecase.dart';
import 'package:go_router/go_router.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';

class VisitEntryView extends StatelessWidget {
  final bool showBackButton;
  final String? initialCustomerId;
  final String? initialCustomerName;

  const VisitEntryView({
    super.key,
    this.showBackButton = false,
    this.initialCustomerId,
    this.initialCustomerName,
  });

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
                    color: context.colors.primaryDark.withValues(alpha: 0.4),
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
                      color: context.colors.success.withValues(alpha: 0.2),
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
                        color: Theme.of(context).colorScheme.onPrimary,
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
      create: (context) => VisitEntryBloc(
        sl<SaveServiceUseCase>(),
        initialCustomerId: initialCustomerId,
        initialCustomerName: initialCustomerName,
      ),
      child: BlocListener<VisitEntryBloc, VisitEntryState>(
        listener: (context, state) {
          if (state.status == VisitEntryStatus.success) {
            _showSuccessPopup(context, AppStrings.serviceEntrySaved);
            context.go('/customers');
          } else if (state.status == VisitEntryStatus.failure) {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text(AppStrings.validationError),
                content: Text(state.errorMessage ?? AppStrings.errorOccurred),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text(AppStrings.ok),
                  ),
                ],
              ),
            );
          }
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(180),
            child: _buildHeader(context),
          ),
          body: SafeArea(
            bottom: false,
            child: CustomScrollView(
              slivers: [
                // Form sections
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(height: 8),
                      // Show pre-filled customer info OR customer selector
                      if (initialCustomerId != null &&
                          initialCustomerName != null)
                        _buildPrefilledCustomerCard(context)
                      else
                        const CustomerSelectorWidget(),
                      SizedBox(height: 16),
                      const ServiceTypeSelectorWidget(),
                      SizedBox(height: 16),
                      const ServiceDetailsCard(),
                      SizedBox(height: 16),
                      const RemarksDateSelectorWidget(),
                      SizedBox(height: 24),
                      BlocBuilder<VisitEntryBloc, VisitEntryState>(
                        builder: (context, state) {
                          if (state.status == VisitEntryStatus.submitting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return const ActionButtonsWidget();
                        },
                      ),
                      SizedBox(height: 160), // extra bottom padding for navbar
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrefilledCustomerCard(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: context.colors.textSecondary.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: context.colors.surface,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: context.colors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.person_rounded,
                color: context.colors.primary,
                size: 24,
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.selectedCustomer,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: context.colors.textSecondary,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    initialCustomerName ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: context.colors.primaryDark,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: context.colors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                AppStrings.autoFilled,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: context.colors.success,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 12,
        20,
        20,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row with Centered Title
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (showBackButton)
                    GestureDetector(
                      onTap: () => context.go('/'),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Theme.of(context).iconTheme.color ?? Theme.of(context).textTheme.bodyLarge?.color,
                        size: 20,
                      ),
                    )
                  else
                    SizedBox(width: 20),

                  // Profile avatar removed as requested
                  SizedBox(width: 32),
                ],
              ),
              Text(
                AppStrings.emiAppTitle,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          // Subtitle
          Text(
            'SERVICE PORTAL',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'New Visit Entry',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 8),
          // Decorative divider
          Container(
            width: 40,
            height: 3,
            decoration: BoxDecoration(
              color: context.colors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
