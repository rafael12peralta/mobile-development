import 'package:flutter/material.dart';

// Post Screen
class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(Icons.add_box, size: 100),
          Text('Crear Publicación'),
        ],
      ),
    );
  }
}