import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:router/router.dart';
import 'package:core_ui/core_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Lock orientation to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await dotenv.load(fileName: ".env");
  await di.init();
  final useFirebase = dotenv.env['USE_FIREBASE']?.toLowerCase() == 'true';
  if (useFirebase) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
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
