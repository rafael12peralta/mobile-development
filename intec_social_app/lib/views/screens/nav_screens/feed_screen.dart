import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  // Obtiene las publicaciones desde Firestore
  Future<List<DocumentSnapshot>> _getPosts() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .orderBy('timestamp', descending: true) // Ordena por timestamp
          .get();
      return querySnapshot.docs;
    } catch (e) {
      print("Error al obtener las publicaciones: $e");
      return [];
    }
  }

  // Función para dar like
  Future<void> _toggleLike(String postId, bool isLiked) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    try {
      DocumentReference postRef =
          FirebaseFirestore.instance.collection('posts').doc(postId);
      if (isLiked) {
        // Si ya le dio like, lo elimina
        await postRef.update({
          'likes': FieldValue.arrayRemove([user.uid]),
        });
      } else {
        // Si no le dio like, lo agrega
        await postRef.update({
          'likes': FieldValue.arrayUnion([user.uid]),
        });
      }
    } catch (e) {
      print("Error al actualizar el like: $e");
    }
  }

  Future<void> _addComment(String postId, String comment) async {
    if (comment.isEmpty) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      DocumentReference postRef =
          FirebaseFirestore.instance.collection('posts').doc(postId);

      // Verificar si los comentarios existen, si no, crearlos
      DocumentSnapshot postSnapshot = await postRef.get();
      List<dynamic> comments = postSnapshot['comments'] ?? [];

      await postRef.update({
        'comments': FieldValue.arrayUnion([
          {
            'userId': user.uid,
            'comment': comment,
            'timestamp': FieldValue.serverTimestamp()
          },
        ]),
      });
    } catch (e) {
      print("Error al agregar comentario: $e");
    }
  }

  // Obtener los datos del usuario
  Future<Map<String, dynamic>> _getUserData(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      return userDoc.data() as Map<String, dynamic>;
    } catch (e) {
      print("Error al obtener los datos del usuario: $e");
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DocumentSnapshot>>(
      future: _getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay publicaciones.'));
        }

        List<DocumentSnapshot> posts = snapshot.data!;

        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            var post = posts[index];
            String postId = post.id;
            String description = post['description'];
            String mediaUrl = post['mediaUrl'] ?? '';
            Timestamp timestamp = post['timestamp'];
            List<dynamic> likes = post['likes'] ?? [];
            List<dynamic> comments = post['comments'] ?? [];

            bool isLiked =
                likes.contains(FirebaseAuth.instance.currentUser?.uid);

            return Card(
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage("https://via.placeholder.com/150"),
                    ),
                    title: FutureBuilder<Map<String, dynamic>>(
                      future: _getUserData(post['userId']),
                      builder: (context, userSnapshot) {
                        if (userSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text('Cargando...');
                        }

                        if (!userSnapshot.hasData ||
                            userSnapshot.data!.isEmpty) {
                          return const Text('Usuario desconocido');
                        }

                        var userData = userSnapshot.data!;
                        return Text(userData['username'] ?? 'Usuario');
                      },
                    ),
                    subtitle: Text(timestamp.toDate().toString()),
                  ),
                  mediaUrl.isNotEmpty
                      ? Image.network(mediaUrl)
                      : const SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(description),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border),
                        onPressed: () => _toggleLike(postId, isLiked),
                      ),
                      IconButton(
                        icon: const Icon(Icons.comment),
                        onPressed: () {
                          // Mostrar ventana emergente para agregar comentario
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              TextEditingController commentController =
                                  TextEditingController();
                              return AlertDialog(
                                title: const Text('Agregar Comentario'),
                                content: TextField(
                                  controller: commentController,
                                  decoration: const InputDecoration(
                                      hintText: 'Escribe tu comentario'),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _addComment(
                                          postId, commentController.text);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Enviar'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  if (comments.isNotEmpty) ...[
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Comentarios:'),
                    ),
                    for (var comment in comments)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FutureBuilder<Map<String, dynamic>>(
                          future: _getUserData(comment['userId']),
                          builder: (context, userSnapshot) {
                            if (userSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const SizedBox.shrink();
                            }

                            if (!userSnapshot.hasData ||
                                userSnapshot.data!.isEmpty) {
                              return const SizedBox.shrink();
                            }

                            var userData = userSnapshot.data!;
                            return Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      userData['profileImageUrl'] ??
                                          "https://via.placeholder.com/150"),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                    "${userData['username']}: ${comment['comment']}"),
                              ],
                            );
                          },
                        ),
                      ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}
