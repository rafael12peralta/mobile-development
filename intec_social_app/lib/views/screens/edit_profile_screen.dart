import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  User? _user;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  File? _imageFile;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _getUserData();
  }

  Future<void> _getUserData() async {
    if (_user != null) {
      try {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(_user!.uid).get();
        if (userDoc.exists) {
          setState(() {
            var data = userDoc.data() as Map<String, dynamic>;
            _nameController.text = data['username'] ?? '';
            _lastNameController.text = data['lastName'] ?? '';
            _bioController.text = data['bio'] ?? '';
            _phoneController.text = data['phone'] ?? '';
            _imageUrl = data['photoUrl'];
          });
        }
      } catch (e) {
        print("Error al obtener los datos: $e");
      }
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile != null) {
      try {
        final storageRef =
            _storage.ref().child("profile_pics/${_user!.uid}.jpg");
        await storageRef.putFile(_imageFile!);
        String downloadUrl = await storageRef.getDownloadURL();
        setState(() {
          _imageUrl = downloadUrl;
        });
      } catch (e) {
        print("Error al subir la imagen: $e");
      }
    }
  }

  Future<void> _updateUserData() async {
    try {
      await _firestore.collection('users').doc(_user!.uid).update({
        'username': _nameController.text,
        'lastName': _lastNameController.text,
        'bio': _bioController.text,
        'phone': _phoneController.text,
        'photoUrl': _imageUrl, // Se pasa directamente el valor de _imageUrl
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Información actualizada')));
    } catch (e) {
      print("Error al actualizar los datos: $e");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar los datos')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Perfil"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : (_imageUrl != null
                              ? NetworkImage(_imageUrl!)
                              : AssetImage('assets/placeholder.png'))
                          as ImageProvider,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: "Apellido"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _bioController,
              decoration: const InputDecoration(labelText: "Biografía"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: "Teléfono"),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _uploadImage(); // Subir la imagen si fue seleccionada
                await _updateUserData(); // Actualizar la información
              },
              child: const Text("Guardar cambios"),
            ),
          ],
        ),
      ),
    );
  }
}
