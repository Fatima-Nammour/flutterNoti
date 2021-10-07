import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../main.dart';

class FirebaseNotification {
  var context;
  FirebaseNotification() {
    context = BuildContext;
    initializeSetting();
  }

  void setUpFirebase() async {
    await FirebaseMessaging.instance.getToken().then((value) {
      fcm_tocken = value!;
      print('from setup token:');
    });

    print("firebase token :  $fcm_tocken");
    await FirebaseMessaging.instance.subscribeToTopic('all');
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    //the next statement will send the message as event was listened
    FirebaseMessaging.onMessage.listen((event) => onMessage(event));
  }

  Future<dynamic> onMessage(RemoteMessage message) async {
    print("onMessage");
    //the message has a notification so i will set my notification variable
    final notification = message.notification;
    if (notification != null) {
      final body = notification.body;
      final title = notification.title;
      //the next if is like a ensuring step
      if (body != null && title != null)
        print('the body and the title of notification are not empty ');
    }
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initializeSetting() async {
    var initializeAndroid = AndroidInitializationSettings('heart');
    var initializeSettings = InitializationSettings(android: initializeAndroid);
    await flutterLocalNotificationsPlugin.initialize(
      initializeSettings,
      onSelectNotification: selectNotification,
    );
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    /*await showDialog(
        context: BuildContext(),
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(payload.toString()),
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
        });*/
  }

  Future<void> displayNotification(String title, String body) async {
    var llocal = tz.local;
    print('display start');
    /*flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        body,
        tz.TZDateTime.now(llocal).add(
          Duration(seconds: 1),
        ),
        NotificationDetails(
            android: AndroidNotificationDetails(
                'channel id', 'channel name', 'channel description')),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);*/

    flutterLocalNotificationsPlugin.show(
      1,
      title,
      body,
      NotificationDetails(
          android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        'channel description',
      )),
      /*payload: await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(body),
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
            })*/
    );
    //await showDialog(context: context, builder: builder);
    print('display end');
  }

  /*void _configureDidReceiveLocalNotificationSubject() {
    var didReceiveLocalNotificationSubject;
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        SecondPage(receivedNotification.payload),
                  ),
                );
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }*/
}
//The response when success
//{"multicast_id":3492100504008076031,"success":1,"failure":0,"canonical_ids":0,"results":[{"message_id":"0:1632929129774937%d6eb4766d6eb4766"}]}

//تم تحديد الحمولة النافعة ("العنصر x") ، والتي سيتم تمريرها مرة أخرى عبر التطبيق الخاص بك عندما ينقر المستخدم على إشعار. لاحظ أنه بالنسبة لأجهزة Android ، ستظهر الإشعارات في الدرج فقط ولن تظهر على شكل إشعار تنبيه مسبق ما لم يتم تعيين أشياء مثل الأولوية / الأهمية بشكل مناسب. راجع مستندات Android (https://developer.android.com/guide/topics/ui/notifiers/notifications.html#Heads-up) للحصول على معلومات إضافية. يُعد نص "شريط الأسهم" الذي يتم تمريره هنا اختياريًا ومخصصًا لنظام Android. يسمح ذلك بعرض النص في شريط الحالة على الإصدارات الأقدم من Android عند عرض الإشعار.

/*void fun() {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
    _firebaseMessaging.getToken();
    _firebaseMessaging.configure(onLaunch: (Map<String, dynamic> msg) {
      print("onLaunch");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Message(this.user, this.event)),
      );
    }, onResume: (Map<String, dynamic> msg) {
      print("onResume");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Message(this.user, this.event)),
      );
    }, onMessage: (Map<String, dynamic> msg) {
      print("onMessage");
    });
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print("IOS");
    });
  }

  //When user clicks on send Button

  Future sendNotification(userData, eventData) async {
    await Messaging.sendToAll(
      title:
          "${toBeginningOfSentenceCase(userData['User']['name'])} on ${toBeginningOfSentenceCase(eventData['Event']['eventName'])} event",
      body: _messageController.text,
      fcmToken: fcmTokenToServer,
    );
  }

  //Messaging.sendToAll()
  static Future<Response> sendToAll(
          {@required String title,
          @required String body,
          @required String fcmToken}) =>
      sendTo(title: title, body: body, fcmToken: fcmToken);

  static Future<Response> sendTo({
    @required String title,
    @required String body,
    @required String fcmToken,
  }) =>
      client.post(
        'https://fcm.googleapis.com/fcm/send',
        body: json.encode({
          'notification': {'body': '$body', 'title': '$title'},
          'priority': 'high',
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
          },
          'to': '$fcmToken',
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
      );*/
