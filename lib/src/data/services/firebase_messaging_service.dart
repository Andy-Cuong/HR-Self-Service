import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  final _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await _messaging.requestPermission();

    // Get registration token
    final token = await _messaging.getToken();
    print('FCM token: $token');

    // Get any message that opens the app from a terminated state
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();

    if (initialMessage != null) {
      print('App opened from notification: ${initialMessage.notification?.title}');
      _handleMessage(initialMessage);
    }

    // Listen for messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a foreground message: ${message.notification?.title}');
      _handleMessage(message);
    });

    // Listen for messages when the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Received a background message: ${message.notification?.title}');
      _handleMessage(message);
    });
  }

  void _handleMessage(RemoteMessage message) {
    // Message handling logic
    
  }
}