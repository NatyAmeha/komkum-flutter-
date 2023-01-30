import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

abstract class INotificationService {
  Future<bool> requestPermission();
  Future<void> createNotificationChannel(String id, String name);
  Future<void> showFirebaseNotification(int id, String? title, String? message,
      String channelId, String channelName,
      {String? image, String? type});
}

class LocalNotificationService extends INotificationService {
  var flutterNotification = FlutterLocalNotificationsPlugin();
  LocalNotificationService() {
    flutterNotification.initialize(
      const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher')),
      // onDidReceiveBackgroundNotificationResponse: backNotificationListener,
      onDidReceiveNotificationResponse: (details) {
        print("notification foreground ${details.payload}");
      },
    );
  }
  @override
  Future<bool> requestPermission() async {
    return await flutterNotification
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestPermission() ??
        true;
  }

  @override
  Future<void> showFirebaseNotification(int id, String? title, String? message,
      String channelId, String channelName,
      {String? image, String? type}) async {
    var notificationDetail = NotificationDetails(
        android: AndroidNotificationDetails(
      channelId,
      channelName,
      largeIcon: image != null
          ? ByteArrayAndroidBitmap.fromBase64String(
              await _base64encodedImage(image))
          : null,
      styleInformation: image != null
          ? BigPictureStyleInformation(
              ByteArrayAndroidBitmap.fromBase64String(
                  await _base64encodedImage(image)),
              contentTitle: title,
              summaryText: message,
              largeIcon: ByteArrayAndroidBitmap.fromBase64String(
                  await _base64encodedImage(image)),
            )
          : null,
    ));
    await flutterNotification.show(id, null, message, notificationDetail,
        payload: type);
  }

  @override
  Future<void> createNotificationChannel(String id, String name) async {
    var channel =
        AndroidNotificationChannel(id, name, importance: Importance.max);
    await flutterNotification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<String> _base64encodedImage(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    final String base64Data = base64Encode(response.bodyBytes);
    return base64Data;
  }
}
