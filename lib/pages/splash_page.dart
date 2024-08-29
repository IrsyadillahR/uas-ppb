import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 1), () {
    //   Navigator.pushReplacementNamed(context, '/login');
    // });
    User? user = _auth.currentUser;

    if (user != null) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, '/dashboard');
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, '/register');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Selamat datang di Aplikasi To Do List'),
      ),
    );
  }
}
