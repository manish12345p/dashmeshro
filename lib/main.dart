import 'package:flutter/material.dart';
import 'package:router/router.dart';
import 'theme/app_theme.dart';
import 'app_navigation/app_navigation_scaffold.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final useFirebase = dotenv.env['USE_FIREBASE']?.toLowerCase() == 'true';
  if (useFirebase) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
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
