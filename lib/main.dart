import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/screens/NotyScreen.dart';
import 'package:flutter_assignment/screens/loginScreen.dart';
import 'package:flutter_assignment/screens/profileScreen.dart';
import 'package:flutter_assignment/screens/signupScreen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'components/fornotifications/firebaseNotification.dart';
import 'components/keys.dart';

//for the notification
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  titlePublic = notification!.title;
  bodyPublic = notification.body;
  FirebaseNotification().displayNotification(titlePublic!, bodyPublic!);
  print("Handling a background message");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseMessaging.onMessage.listen((message) async {
    RemoteNotification? notification = message.notification;
    titlePublic = notification!.title;
    bodyPublic = notification.body;
    FirebaseNotification().displayNotification(titlePublic!, bodyPublic!);

    print('onMessage: $titlePublic \n the body is: $bodyPublic');
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) async {
    RemoteNotification? notification = message.notification;
    titlePublic = notification!.title;
    bodyPublic = notification.body;
    FirebaseNotification().displayNotification(titlePublic!, bodyPublic!);

    print("onMessageOpenedApp: $message");
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  //for Local Storage
  await GetStorage.init();
  //for Firebase
  final _init = Firebase.initializeApp();
  dynamic init() => FutureBuilder<FirebaseApp>(
        future: _init,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            FirebaseNotification().setUpFirebase();
            return MyApp();
          }
          return Container();
        },
      );

  runApp(init());
}

String fcm_tocken = "";
String? titlePublic;
String? bodyPublic;
GetStorage Box = GetStorage();
var imgPath;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Box.read(keyIsLogged) == true) {
      return ResponsiveSizer(builder: (context, orientation, screenType) {
        return MaterialApp(
            routes: <String, WidgetBuilder>{
              '/LoginScreen': (BuildContext context) => LoginScreen(),
              '/SignupScreen': (BuildContext context) => SignupScreen(),
              '/ProfileScreen': (BuildContext context) => ProfileScreen(),
            },
            debugShowCheckedModeBanner: false,
            theme: ThemeData(),
            home: ProfileScreen());
      });
    } else {
      return ResponsiveSizer(builder: (context, orientation, screenType) {
        return MaterialApp(
          routes: <String, WidgetBuilder>{
            '/LoginScreen': (BuildContext context) => LoginScreen(),
            '/SignupScreen': (BuildContext context) => SignupScreen(),
            '/ProfileScreen': (BuildContext context) => ProfileScreen(),
          },
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          home: NotyScreen(),
        );
      });
    }
  }
}

//import 'dart:io';
// ...
// try {
//   final result = await InternetAddress.lookup('example.com');
//   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//     print('connected');
//   }
// } on SocketException catch (_) {
//   print('not connected');
// }
