import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/input_widget.dart';
import '../components/style.dart';
import '../components/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  String? email;
  String? password;

  // @override
  // void initState() {
  //   super.initState();
  //   User? user = _auth.currentUser;

  //   if (user != null) {
  //     Future.delayed(Duration.zero, () {
  //       Navigator.pushReplacementNamed(context, '/dashboard');
  //     });
  //   }
  //   // else {
  //   //   Future.delayed(Duration.zero, () {
  //   //     Navigator.pushReplacementNamed(context, '/login');
  //   //   });
  //   // }
  // }

  void login() async {
    setState(() {
      isLoading = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);

      Navigator.pushReplacementNamed(
        context,
        '/dashboard',
      );
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    Text('Login', style: headerStyle(level: 1)),
                    const Text(
                      'Login to your account',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 50),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              InputWidget(
                                  'Email',
                                  TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      onChanged: (String value) => setState(() {
                                            email = value;
                                          }),
                                      validator: notEmptyValidator,
                                      decoration: customInputDecoration(
                                          "email@email.com"))),
                              InputWidget(
                                  'Password',
                                  TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      onChanged: (String value) => setState(() {
                                            password = value;
                                          }),
                                      validator: notEmptyValidator,
                                      obscureText: true,
                                      decoration: customInputDecoration(""))),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                width: double.infinity,
                                child: FilledButton(
                                    style: buttonStyle,
                                    child: Text('Login',
                                        style: headerStyle(level: 3)),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        login();
                                      }
                                    }),
                              )
                            ],
                          )),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Belum punya akun? '),
                        InkWell(
                          onTap: () =>
                              Navigator.pushNamed(context, '/register'),
                          child: const Text('Daftar di sini',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
