import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessageApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initFirebaseMessaging() async {
    // Request permission (iOS-specific but needed on all platforms for completeness)
    await _firebaseMessaging.requestPermission();

    // 🔥 Await the token properly
    final token = await _firebaseMessaging.getToken();
    print('Firebase Messaging Token: $token');

    // Optional: handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
  }
}
