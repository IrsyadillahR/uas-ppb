import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas_ppb/components/list_item.dart';
import 'package:uas_ppb/model/akun.dart';
import 'package:uas_ppb/model/todo.dart';

class TodoPage extends StatefulWidget {
  final Akun akun;
  const TodoPage({super.key, required this.akun});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final firestore = FirebaseFirestore.instance;

  Future<List<Todo>> getTodo() async {
    List<Todo> listTodo = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firestore.collection('todos').get();

      for (var documents in querySnapshot.docs) {
        listTodo.add(
          Todo(
            uid: documents.data()['uid'],
            docId: documents.data()['docId'],
            judul: documents.data()['judul'],
            deskripsi: documents.data()['deskripsi'],
            nama: documents.data()['nama'],
          ),
        );
      }
    } catch (e) {
      print(e);
    }
    return listTodo;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(
          left: 8,
          top: 8,
        ),
        width: double.infinity,
        child: FutureBuilder<List<Todo>>(
          future: getTodo(), // Memanggil Future sekali
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Tidak ada to do.'));
            } else {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListItem(
                    todo: snapshot.data![index],
                    akun: widget.akun,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
