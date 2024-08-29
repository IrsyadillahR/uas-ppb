import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/style.dart';
import '../components/input_widget.dart';
import '../components/validators.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  String? nama;
  String? email;
  String? noHP;

  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void register() async {
    setState(() {
      isLoading = true;
    });
    try {
      CollectionReference akunCollection = _db.collection('akun');

      final password = _password.text;
      await _auth.createUserWithEmailAndPassword(
          email: email!, password: password);

      final docId = akunCollection.doc().id;
      await akunCollection.doc(docId).set({
        'uid': _auth.currentUser!.uid,
        'nama': nama,
        'email': email,
        'noHP': noHP,
        'docId': docId,
        'role': 'user',
      });

      Navigator.pushReplacementNamed(
        context,
        '/login',
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
                    const SizedBox(height: 30),
                    Text('Register', style: headerStyle(level: 1)),
                    const Text(
                      'Create your profile to start your journey',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            InputWidget(
                              'Nama',
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (String value) => setState(
                                  () {
                                    nama = value;
                                  },
                                ),
                                validator: notEmptyValidator,
                                decoration:
                                    customInputDecoration("Nama Lengkap"),
                              ),
                            ),
                            InputWidget(
                              'Email',
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (String value) => setState(
                                  () {
                                    email = value;
                                  },
                                ),
                                validator: notEmptyValidator,
                                decoration:
                                    customInputDecoration("email@email.com"),
                              ),
                            ),
                            InputWidget(
                              'No. Handphone',
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (String value) => setState(
                                  () {
                                    noHP = value;
                                  },
                                ),
                                validator: notEmptyValidator,
                                decoration:
                                    customInputDecoration("+62 80000000"),
                              ),
                            ),
                            InputWidget(
                              'Password',
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _password,
                                validator: notEmptyValidator,
                                obscureText: true,
                                decoration: customInputDecoration(""),
                              ),
                            ),
                            InputWidget(
                              'Konfirmasi Password',
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    passConfirmationValidator(value, _password),
                                obscureText: true,
                                decoration: customInputDecoration(""),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: double.infinity,
                              child: FilledButton(
                                style: buttonStyle,
                                child: Text('Register',
                                    style: headerStyle(level: 2)),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    register();
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Sudah punya akun? '),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text(
                            'Login di sini',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
      ),
    );
  }
}
