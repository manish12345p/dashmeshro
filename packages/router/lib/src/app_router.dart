import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_page/home_page.dart';
import 'package:calendar/calendar.dart';
import 'package:customer_directory/customer_directory.dart';
import 'package:emi_page/emi_page.dart';
import 'package:visit_entry/visit_entry.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

GoRouter createAppRouter({
  required Widget Function(Widget child) shellBuilder,
}) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) =>
            NoTransitionPage(child: shellBuilder(const HomePageView())),
      ),
      GoRoute(
        path: '/calendar',
        builder: (context, state) => BlocProvider(
          create: (_) => sl<CalendarBloc>()
            ..add(
              CalendarEvent.loadMonth(
                DateTime.now().year,
                DateTime.now().month,
              ),
            ),
          child: const CalendarView(),
        ),
      ),
      GoRoute(
        path: '/customers',
        pageBuilder: (context, state) => NoTransitionPage(
          child: shellBuilder(const CustomerDirectoryView()),
        ),
        routes: [
          GoRoute(
            path: 'new',
            builder: (context, state) => const NewClientProfileView(),
          ),
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return CustomerDetailsView(customerId: id);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/emi',
        pageBuilder: (context, state) =>
            NoTransitionPage(child: shellBuilder(const EmiPageView())),
      ),
      GoRoute(
        path: '/service',
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final showBackButton = extra?['showBackButton'] as bool? ?? false;
          final customerId = extra?['customerId'] as String?;
          final customerName = extra?['customerName'] as String?;
          return NoTransitionPage(
            child: shellBuilder(
              VisitEntryView(
                showBackButton: showBackButton,
                initialCustomerId: customerId,
                initialCustomerName: customerName,
              ),
            ),
          );
        },
      ),
    ],
  );
}
