import 'package:flutter/material.dart';

class LoginScreenClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    final Path path = Path();
    path.lineTo(0.0, size.height - 440);

    path.lineTo(size.width, size.height - 340);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
