import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    super.key,
    this.imageProvider, required this.radius,
  });

  final ImageProvider<Object>? imageProvider;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: radius,
      child: CircleAvatar(
        radius: radius - 5,
        backgroundImage: imageProvider,
      ),
    );
  }
}