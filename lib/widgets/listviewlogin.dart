import 'package:flutter/material.dart';
import 'package:flutter_assignment/components/keys.dart';
import 'package:flutter_assignment/controllers/loginController.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../main.dart';

class ListViewLogin extends GetView<LoginController> {
  final TextEditingController passwordTextCont = TextEditingController();
  final TextEditingController emailTextCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return ListView(
      children: [
        SizedBox(
          height: 80.0,
        ),
        //Hello
        Container(
          margin: EdgeInsets.only(
            left: 30.0,
          ),
          child: Text(
            'Hello \nAgain!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 50.0,
            ),
          ),
        ),
        SizedBox(
          height: height * 0.15,
        ),
        //TextField password
        Container(
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          margin: EdgeInsets.only(bottom: 20.0),
          width: width / 2 + width * 0.30,
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
              validator: (String? value) {
                return (value != null && value.length < 6)
                    ? ' length of password should be at least 6'
                    : null;
              },
              controller: passwordTextCont,
              onChanged: (text) {
                controller.password = text;
                print(controller.password);
              },
              style: TextStyle(fontSize: 18.0.sp, color: Colors.blue),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.grey),
                focusColor: Color(0xFF36506B),
              ),
            ),
          ),
        ),
        //TextField Email
        Container(
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          margin: EdgeInsets.only(bottom: 20.0),
          //width: width / 2 + width * 0.30,
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
              controller: emailTextCont,
              onChanged: (text) {
                controller.email = text;
                print(controller.email);
              },
              style: TextStyle(fontSize: 18.0.sp, color: Colors.blue),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                labelText: 'Email',
                hintText: 'example@gmail.com',
                labelStyle: TextStyle(color: Colors.grey),
                focusColor: Color(0xFF36506B),
              ),
            ),
          ),
        ),
        //Login Button
        Container(
          width: 100,
          height: 100,
          margin:
              EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0, left: 10.0),
          child: InkWell(
            onTap: () async {
              print(controller.email);
              print(controller.password);
              //?
              Box.write(keyName, controller.name);
              Box.write(keyPassword, controller.password);
              if (controller.email.isEmpty || controller.email.isEmpty) {
                await showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Please fill data '),
                        actions: [
                          ElevatedButton(
                            child: Text(
                              'OK ',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              }
              await controller.postRequest(
                  controller.email.trim(), controller.password.trim());
              if (controller.statusCode == 200) {
                Box.write(keyIsLogged, true);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/ProfileScreen', (Route<dynamic> route) => false);
              }
            },
            child: Stack(
              children: [
                Positioned(
                  right: 30.0,
                  top: 0.0,
                  bottom: 10.0,
                  child: ClipOval(
                      child: Container(
                    width: 100,
                    height: 10,
                    color: Color(0xFFFFE589),
                  )),
                ),
                Positioned(
                  right: 70.0,
                  top: 20.0,
                  bottom: 20.0,
                  //  left: 40.0,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 35.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 30.0),
                child: InkWell(
                  onTap: () {
                    print('go Signup');
                    Navigator.pushNamedAndRemoveUntil(context, '/SignupScreen',
                        (Route<dynamic> route) => false);
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 20.0.sp,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 30.0),
                child: InkWell(
                  onTap: () => print('Forget Password'),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Text(
                    'Forget Password',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 20.0.sp,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}
