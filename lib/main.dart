import 'package:flutter/material.dart';
import 'package:router/router.dart';
import 'theme/app_theme.dart';
import 'app_navigation/app_navigation_scaffold.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = createAppRouter(
    shellBuilder: (child) => AppNavigationScaffold(child: child),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Dashmeshro',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: _appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
