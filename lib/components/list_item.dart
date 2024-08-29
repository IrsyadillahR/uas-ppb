import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas_ppb/model/akun.dart';
import 'package:uas_ppb/model/todo.dart';

class ListItem extends StatefulWidget {
  final Todo todo;
  final Akun akun;
  const ListItem({
    super.key,
    required this.todo,
    required this.akun,
  });

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  final firestore = FirebaseFirestore.instance;

  void deleteTodo() async {
    try {
      await firestore.collection('todos').doc(widget.todo.docId).delete();

      // menghapus gambar dari storage

      Navigator.popAndPushNamed(context, '/dashboard');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      textColor: Colors.black,
      title: Text(widget.todo.judul),
      subtitle: Text(widget.todo.deskripsi),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          deleteTodo();
        },
      ),
    );
  }
}
