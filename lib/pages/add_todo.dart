import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uas_ppb/components/input_widget.dart';
import 'package:uas_ppb/components/style.dart';
import 'package:uas_ppb/components/validators.dart';
import 'package:uas_ppb/model/akun.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  String? judul;
  String? deskripsi;

  void addTransaksi(Akun akun) async {
    setState(() {
      isLoading = true;
    });
    try {
      CollectionReference laporanCollection = firestore.collection('todos');

      // Convert DateTime to Firestore Timestamp

      final id = laporanCollection.doc().id;

      await laporanCollection.doc(id).set({
        'uid': auth.currentUser!.uid,
        'docId': id,
        'judul': judul,
        'deskripsi': deskripsi,
        'nama': akun.nama,
      }).catchError((e) {
        throw e;
      });
      Navigator.popAndPushNamed(context, '/dashboard');
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final Akun akun = arguments['akun'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Tambah Todo', style: headerStyle(level: 3)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                  child: Container(
                    margin: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        InputWidget(
                            'Judul Todo',
                            TextFormField(
                                onChanged: (String value) => setState(() {
                                      judul = value;
                                    }),
                                validator: notEmptyValidator,
                                decoration:
                                    customInputDecoration("Judul laporan"))),
                        InputWidget(
                            "Deskripsi Todo",
                            TextFormField(
                              onChanged: (String value) => setState(() {
                                deskripsi = value;
                              }),
                              keyboardType: TextInputType.multiline,
                              minLines: 3,
                              maxLines: 5,
                              decoration: customInputDecoration(
                                  'Deskripsikan semua di sini'),
                            )),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            style: buttonStyle,
                            onPressed: () {
                              addTransaksi(akun);
                            },
                            child: Text(
                              'Kirim Laporan',
                              style: headerStyle(level: 3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
