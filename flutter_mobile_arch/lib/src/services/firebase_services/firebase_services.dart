import 'package:firebase_messaging/firebase_messaging.dart';
import '../../app_configs/app_logger.dart';
import '../service_locator.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final AppLogger logger = getIt<AppLogger>();

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    logger.logInfo("Title: ${message.notification?.title}");
    logger.logInfo("Body: ${message.notification?.body}");
    logger.logInfo("Payload: ${message.data}");
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    logger.logInfo("Message received: ${message.notification?.title}");
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    logger.logInfo('FCM Token: $fcmToken');
    initPushNotification();
  }
}
