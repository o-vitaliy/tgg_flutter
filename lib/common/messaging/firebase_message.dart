import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:redux/redux.dart';

import 'messaging_delegator.dart';

class FireBaseMessages {
  final FirebaseMessaging _firebaseMessaging;

  static MessageDelegator delagator;

  FireBaseMessages(store, this._firebaseMessaging) {
    delagator = MessageDelegator(store);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async =>
          messageHandler(message),
      onBackgroundMessage: messageHandler,
      onLaunch: (Map<String, dynamic> message) async => messageHandler(message),
      onResume: (Map<String, dynamic> message) async => messageHandler(message),
    );
  }

  static Future<dynamic> messageHandler(Map<String, dynamic> message) async {
    print(message);
    if (message.containsKey('data')) {
      // Handle data message
      try {
        final Map<String, dynamic> data =
            Map<String, dynamic>.from(message['data']);
        delagator.delegate(data);
      } catch (e) {
        print(e);
      }
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }
  }

  factory FireBaseMessages.create(
      final Store store, final FirebaseMessaging firebaseMessaging) {
    return FireBaseMessages(store, firebaseMessaging);
  }
}
