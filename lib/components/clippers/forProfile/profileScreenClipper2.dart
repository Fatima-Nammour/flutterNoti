import 'package:flutter/material.dart';

class ProfileScreenClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    final Path path = Path();
    path.lineTo(0.0, size.height);

    path.lineTo(size.width, 0.0);

    path.lineTo(0.0, size.height / 2);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
