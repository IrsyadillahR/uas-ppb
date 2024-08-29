import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uas_ppb/components/style.dart';
import 'package:uas_ppb/model/akun.dart';
import 'package:uas_ppb/pages/profile_page.dart';
import 'package:uas_ppb/pages/todo_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedIndex = 0;
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    getAkun();
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Akun akun = Akun(
    uid: '',
    docId: '',
    nama: '',
    noHP: '',
    email: '',
    role: '',
  );

  void getAkun() async {
    setState(() {
      isLoading = true;
    });
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('akun')
          .where('uid', isEqualTo: _auth.currentUser!.uid)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userData = querySnapshot.docs.first.data();

        setState(() {
          akun = Akun(
            uid: userData['uid'],
            nama: userData['nama'],
            noHP: userData['noHP'],
            email: userData['email'],
            docId: userData['docId'],
            role: userData['role'],
          );
        });
      }
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

  void keluar(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    await _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'));
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    pages = <Widget>[
      TodoPage(akun: akun),
      ProfilePage(akun: akun),
    ];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: const Icon(Icons.add, size: 35),
        onPressed: () {
          Navigator.pushNamed(context, '/add', arguments: {
            'akun': akun,
          });
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: Text(
          'To Do List',
          style: headerStyle(level: 2),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: primaryColor,
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.white,
        selectedFontSize: 16,
        unselectedItemColor: Colors.grey[800],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Profile',
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : pages.elementAt(selectedIndex),
    );
  }
}
