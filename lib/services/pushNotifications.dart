import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mellimeter/services/auth.dart';

class PushNotificationService {
  final FirebaseMessaging fcm = FirebaseMessaging();

  Future initialise() async {
    if (Platform.isIOS) {
      fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    fcm.configure(
      // called when app in the foreground
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage : $message");
      },
      // called when app has been closed completely
      // onClick on notification
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch : $message");
      },
      // called when app is in the background
      // onClick on notification
      onResume: (Map<String, dynamic> message) async {
        print("onResume : $message");
      },
    );
  }

  Future getDeviceToken() async {
    String deviceToken = await fcm.getToken();
    print('device token : $deviceToken');
  }

  void subscribeToAdmin() async {
    fcm.subscribeToTopic("Admin");
  }
}
