import 'package:flutter/material.dart';

class SignupScreenClipper extends CustomClipper<Path>{

  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    final Path path = Path();
    path.lineTo(0.0, size.height/4);

    path.lineTo(size.width/5, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;

}