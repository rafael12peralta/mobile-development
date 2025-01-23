import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> registerUser({
    required String email,
    required String password,
    required String username,
    required String lastName,
    required String phone,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Guardar datos adicionales en Firestore
      await _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'username': username,
        'lastName': lastName,
        'phone': phone,
        'createdAt': FieldValue.serverTimestamp(),
      });

      Fluttertoast.showToast(
        msg: "Cuenta creada con éxito!",
        toastLength: Toast.LENGTH_SHORT,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}
