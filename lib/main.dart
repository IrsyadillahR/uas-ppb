import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uas_ppb/firebase_options.dart';
import 'package:uas_ppb/pages/add_todo.dart';
import 'package:uas_ppb/pages/dashboard_page.dart';
import 'package:uas_ppb/pages/login_page.dart';
import 'package:uas_ppb/pages/register_page.dart';
import 'package:uas_ppb/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lapor Book',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/add': (context) => const AddTodo(),
      },
    ),
  );
}
