import 'package:flutter/material.dart';

class ImageSquareTitle extends StatelessWidget {
  final String imagePath;
  const ImageSquareTitle({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          color: Colors.grey[200],
        ),
        child: Image.asset(
          imagePath,
          height: 100.0,
        ));
  }
}
