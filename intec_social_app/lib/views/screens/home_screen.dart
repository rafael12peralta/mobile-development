import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'nav_screens/feed_screen.dart';
import 'nav_screens/post_screen.dart';
import 'nav_screens/profile_screen.dart';
import 'nav_screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    if (_user != null) {
      _getUserData();
    }
  }

  Future<void> _getUserData() async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(_user!.uid).get();
      if (userDoc.exists) {
        setState(() {
          _userData = userDoc.data() as Map<String, dynamic>;
        });
      }
    } catch (e) {
      print("Error al obtener datos del usuario: $e");
    }
  }

  final List<Widget> _screens = [
    const FeedScreen(),
    const SearchScreen(),
    const PostScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _userData != null
            ? Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(_userData?['photoUrl'] ?? 'https://via.placeholder.com/150'),
              radius: 18,
            ),
            SizedBox(width: 10),
            Text(_userData?['username'] ?? 'Cargando...')
          ],
        )
            : const CircularProgressIndicator(),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: () {
              // Lógica para agregar una nueva publicación
            },
          ),
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              // Lógica para ir a los mensajes directos
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex], // Mostrar la pantalla seleccionada
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Búsqueda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Publicar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
