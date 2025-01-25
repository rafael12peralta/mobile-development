import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intec_social_app/controllers/auth/auth_controller.dart';
import '../edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    if (_user != null) {
      try {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(_user!.uid).get();
        if (userDoc.exists) {
          setState(() {
            _userData = userDoc.data() as Map<String, dynamic>;
          });
        } else {
          setState(() {
            _userData = {}; // Datos vacíos si no existen
          });
          print("El documento del usuario no existe.");
        }
      } catch (e) {
        print("Error al obtener los datos del usuario: $e");
      }
    }
  }

  // Método para cerrar sesión usando el controlador
  void _signOut() async {
    try {
      await AuthController().signOut(); // Usar el método de signOut del controlador
      Navigator.of(context).pushReplacementNamed('/login'); // Redirige a la pantalla de login
    } catch (e) {
      // Si ocurre un error al cerrar sesión
      print("Error al cerrar sesión: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al cerrar sesión.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Perfil")),
        body: const Center(child: Text("Por favor, inicia sesión para ver tu perfil.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfileScreen()),
              ).then((_) {
                // Recargar datos después de regresar de la pantalla de edición
                _getUserData();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: _signOut, // Llamar al método de cierre de sesión
          ),
        ],
      ),
      body: _userData == null
          ? const Center(child: CircularProgressIndicator())
          : _userData!.isEmpty
              ? const Center(child: Text("No se encontraron datos del usuario."))
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: _userData?['photoUrl'] != null
                                ? NetworkImage(_userData!['photoUrl'])
                                : const AssetImage('assets/placeholder.png') as ImageProvider,
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _userData?['username'] ?? 'Cargando...',
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                _userData?['email'] ?? 'Cargando...',
                                style: const TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Biografía",
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _userData?['bio'] ?? 'Sin biografía',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildProfileStat("Seguidores", _userData?['followers'] ?? 0),
                          _buildProfileStat("Siguiendo", _userData?['following'] ?? 0),
                          _buildProfileStat("Publicaciones", _userData?['posts'] ?? 0),
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildProfileStat(String label, int value) {
    return Column(
      children: [
        Text(
          "$value",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
