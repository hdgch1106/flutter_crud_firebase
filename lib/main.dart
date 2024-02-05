import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:crud_firebase/firebase_options.dart';
import 'package:crud_firebase/config/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/constants/env.dart';
import 'config/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Environment.initEnvironment();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "CRUD Firebase",
      routerConfig: appRouter,
      theme: AppTheme().getTheme(),
    );
  }
}
