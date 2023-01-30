import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:komkum/firebase_options.dart';
import 'package:komkum/service/notification_service.dart';
import 'package:komkum/utils/constants.dart';
import 'package:komkum/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeFCM(LocalNotificationService());
  // var dynamicLinkData = await handleDynamicLink();
  // await initUniLinks();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Komkum',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routerConfig: AppRoute.routes,
    );
  }
}

Future<void> initializeFCM(INotificationService notificationService) async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  await notificationService.createNotificationChannel(
      Constants.DEFAULT_NOTIFICATION_CHANNEL_ID,
      Constants.DEFAULT_NOTIFICATION_CHANNEL_NAME);
  FirebaseMessaging.onMessage.listen(
    (message) {
      var notification = message.notification;
      var android = message.notification?.android;
      print("firebase fcm data ${message.data}");
      if (message.data != null) {
        notificationService.showFirebaseNotification(
            1,
            message.data["title"],
            message.data["body"],
            Constants.DEFAULT_NOTIFICATION_CHANNEL_ID,
            Constants.DEFAULT_NOTIFICATION_CHANNEL_NAME,
            image: message.data["imageUrl"],
            type: message.data["type"]);
      }
    },
  );
}
