import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Número de publicaciones en el feed
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage("https://via.placeholder.com/150"),
                ),
                title: Text("Usuario $index"),
                subtitle: Text("Fecha de publicación"),
              ),
              Image.network("https://via.placeholder.com/600x300"),
              Row(
                children: [
                  IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.comment), onPressed: () {}),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Descripción de la publicación"),
              ),
            ],
          ),
        );
      },
    );
  }
}