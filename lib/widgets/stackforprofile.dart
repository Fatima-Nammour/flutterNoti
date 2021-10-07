import 'package:flutter/material.dart';
import 'package:flutter_assignment/components/clippers/forProfile/profileScreenClipper.dart';
import 'package:flutter_assignment/components/clippers/forProfile/profileScreenClipper2.dart';

class StackProfile extends StatelessWidget {
  const StackProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        ClipPath(
          clipper: ProfileScreenClipper2(),
          child: Container(
            color: Color(0xFF36506B),
            height: height,
            width: width,
          ),
        ),
        ClipPath(
          clipper: ProfileScreenClipper(),
          child: Container(
            color: Color(0xFFEB467B),
            height: height / 5,
            width: width / 2,
          ),
        ),
      ],
    );
  }
}
