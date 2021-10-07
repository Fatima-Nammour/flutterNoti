import 'package:flutter/material.dart';

class LoginScreenClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    final Path path = Path();

    path.lineTo(0.0, size.height - 370);

    path.lineTo(size.width, size.height - 560);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
