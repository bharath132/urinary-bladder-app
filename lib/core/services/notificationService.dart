import 'dart:io';
import 'dart:ui'; // Import dart:ui for Color

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart'; // Add this

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool isInitialized = false;

  bool get isReady => isInitialized;

  Future<void> initNotification() async {
    if (isInitialized) return;
    if (Platform.isAndroid) {
      if (await Permission.notification.isDenied ||
          await Permission.notification.isPermanentlyDenied) {
        await Permission.notification.request();
      }
    }

    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    final initializationSettingsIOS = DarwinInitializationSettings();

    final initsetting = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await notificationsPlugin.initialize(initsetting);
    isInitialized = true;
  }

  NotificationDetails notificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        channelDescription: 'Daily Notification Channel',
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        showWhen: true,
        icon: '@mipmap/waterdrop',
        enableLights: true,
        enableVibration: true,
        styleInformation: DefaultStyleInformation(
          true,
          true,
        ),
      ),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String title = 'ALert',
    String body = ' Capacity is full',
  }) async {
    return notificationsPlugin.show(id, title, body, notificationDetails());
  }
}
