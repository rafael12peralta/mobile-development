import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OtherUserProfileScreen extends StatefulWidget {
  final String userId; // Recibimos el ID del usuario que se desea ver

  const OtherUserProfileScreen({super.key, required this.userId});

  @override
  _OtherUserProfileScreenState createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  Map<String, dynamic>? _otherUserData;
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    if (_user != null) {
      _getOtherUserData();
    }
  }

  // Obtiene los datos del otro usuario
  Future<void> _getOtherUserData() async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(widget.userId).get();
      if (userDoc.exists) {
        setState(() {
          _otherUserData = userDoc.data() as Map<String, dynamic>;
        });
        // Verificar si ya está siguiendo al otro usuario
        _checkIfFollowing();
      } else {
        setState(() {
          _otherUserData = {}; // Datos vacíos si no existe
        });
        print("El documento del otro usuario no existe.");
      }
    } catch (e) {
      print("Error al obtener los datos del otro usuario: $e");
    }
  }

  // Verifica si el usuario está siguiendo al otro
  void _checkIfFollowing() {
    if (_user != null && _otherUserData != null) {
      setState(() {
        isFollowing = _user!.uid == _otherUserData!['followers']?.contains(_user!.uid);
      });
    }
  }

  // Método para seguir al otro usuario
  Future<void> _followUser(String followedUserId) async {
    try {
      final userDoc = _firestore.collection('users').doc(_user!.uid);
      final followedUserDoc = _firestore.collection('users').doc(followedUserId);

      // Agregar el ID del usuario seguido al array de 'following' del usuario actual
      await userDoc.update({
        'following': FieldValue.arrayUnion([followedUserId])
      });

      // Agregar el ID del usuario actual al array de 'followers' del usuario seguido
      await followedUserDoc.update({
        'followers': FieldValue.arrayUnion([_user!.uid])
      });

      // Actualizar los datos del usuario
      _getOtherUserData(); // Actualiza los datos para reflejar el cambio en la interfaz

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Usuario seguido correctamente')));
    } catch (e) {
      print("Error al seguir usuario: $e");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al seguir usuario')));
    }
  }

  // Método para dejar de seguir al otro usuario
  Future<void> _unfollowUser() async {
    try {
      // Eliminar el usuario actual de la lista de seguidores del otro usuario
      await _firestore.collection('users').doc(widget.userId).update({
        'followers': FieldValue.arrayRemove([_user!.uid]),
      });
      // Eliminar el otro usuario de la lista de seguidos del usuario actual
      await _firestore.collection('users').doc(_user!.uid).update({
        'following': FieldValue.arrayRemove([widget.userId]),
      });

      setState(() {
        isFollowing = false;
      });
    } catch (e) {
      print("Error al dejar de seguir al usuario: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_otherUserData == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Perfil de Usuario"),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil de Usuario"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _otherUserData?['photoUrl'] != null
                      ? NetworkImage(_otherUserData!['photoUrl'])
                      : const AssetImage('assets/placeholder.png') as ImageProvider,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _otherUserData?['username'] ?? 'Cargando...',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _otherUserData?['email'] ?? 'Cargando...',
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
              _otherUserData?['bio'] ?? 'Sin biografía',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFollowButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFollowButton() {
    return ElevatedButton(
      onPressed: isFollowing ? _unfollowUser : () => _followUser(widget.userId),
      child: Text(isFollowing ? "Dejar de Seguir" : "Seguir"),
    );
  }
}
