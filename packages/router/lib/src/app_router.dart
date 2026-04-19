import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_page/home_page.dart';
import 'package:calendar/calendar.dart';
import 'package:customer_directory/customer_directory.dart';
import 'package:emi_page/emi_page.dart';
import 'package:service_entry/service_entry.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createAppRouter({
  required Widget Function(Widget child) shellBuilder,
}) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => shellBuilder(child),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomePageView(),
          ),
          GoRoute(
            path: '/calendar',
            builder: (context, state) => const CalendarView(),
          ),
          GoRoute(
            path: '/customers',
            builder: (context, state) => const CustomerDirectoryView(),
          ),
          GoRoute(
            path: '/emi',
            builder: (context, state) => const EmiPageView(),
          ),
          GoRoute(
            path: '/service',
            builder: (context, state) => const ServiceEntryView(),
          ),
        ],
      ),
    ],
  );
}
