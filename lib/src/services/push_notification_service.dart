// import 'dart:async';
// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:googleapis_auth/auth_io.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:megataxi_app/firebase_options.dart';
// import 'package:megataxi_app/src/services/notification.dart';

// final pushNotificationService = PushNotificationService();

// class PushNotificationService {
//   //late final ServiceAccountCredentials _accountCredentials;
//   //late final AuthClient _client;
//   static FirebaseMessaging messaging = FirebaseMessaging.instance;
//   String fcmUrl =
//       'https://fcm.googleapis.com/v1/projects/megataxi-app-7ea55/messages:send';
//   final serviceAccountPath = 'assets/megataxi-app-7ea55-d1887d351c7f.json';
//   final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

//   static String? token;
//   static final StreamController<String> _messageStreamController =
//       StreamController.broadcast();
//   static Stream<String> get messageStream => _messageStreamController.stream;

//   static Future<void> _backgroundHandler(RemoteMessage message) async {
//     _messageStreamController
//         .add(message.notification?.title ?? "No hay titulo");
//     final data = message.data;
//     final title = data['title'];
//     final body = data['body'];
//     final imageUrl = data['image'];
//     final userToken = data['token'];

//     if (title != null && body != null) {
//       await mostrarNotificacion(title, body, imageUrl);
//     }

//     if (userToken != null) {
//       await pushNotificationService.sendNotificationToAllUsers(
//           title, body, imageUrl);
//     }
//   }

//   static Future<void> _onMessageHandler(RemoteMessage message) async {
//     _messageStreamController
//         .add(message.notification?.title ?? "No hay titulo");
//     final data = message.data;
//     final title = data['title'];
//     final body = data['body'];
//     final imageUrl = data['image'];
//     final userToken = data['token'];

//     if (title != null && body != null) {
//       await mostrarNotificacion(title, body, imageUrl);
//     }

//     if (userToken != null) {
//       await pushNotificationService.sendNotificationToAllUsers(
//           title, body, imageUrl);
//     }
//   }

//   static Future<void> _onMessageOpenApp(RemoteMessage message) async {
//     _messageStreamController
//         .add(message.notification?.title ?? "No hay titulo");
//   }

//   Future<void> initializeApp() async {
//     // try {
//     //   await dotenv.load(fileName: '.env');
//     //   final serviceAccountPath = dotenv.env['SERVICE_ACCOUNT_PATH'];
//     //   _accountCredentials = ServiceAccountCredentials.fromJson(
//     //       json.decode(await rootBundle.loadString(serviceAccountPath!)));

//     //   final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
//     //   _client = await clientViaServiceAccount(_accountCredentials, scopes);
//     // } catch (e) {
//     //   //print('Error loading .env file: $e');
//     //   rethrow;
//     // }

//     await Firebase.initializeApp(
//         options: DefaultFirebaseOptions.currentPlatform);
//     await initNotification();
//     messaging.requestPermission();
//     //obtener el token del dispositivo
//     token = await FirebaseMessaging.instance.getToken();
//     // print('Token: $token');

//     FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
//     FirebaseMessaging.onMessage.listen(_onMessageHandler);
//     FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
//   }

// //enviar notificaciones a todos los usuarios
//   Future<void> sendNotificationToAllUsers(
//       String title, String body, String? imageUrl) async {
//     final accountCredentials = ServiceAccountCredentials.fromJson(
//         json.decode(await rootBundle.loadString(serviceAccountPath)));

//     final client = await clientViaServiceAccount(accountCredentials, scopes);
//     final mensaje = {
//       "message": {
//         "topic": "all",
//         "notification": {
//           "title": title,
//           "body": body,
//         },
//         "data": {
//           "title": title,
//           "body": body,
//           "click_action": "FLUTTER_NOTIFICATION_CLICK",
//         }
//       }
//     };

//     if (imageUrl != null) {
//       mensaje['message']?['data'] ??= {};
//       (mensaje['message']?['data'] as Map<String, dynamic>)['image'] = imageUrl;
//     }

//     final response = await client.post(
//       Uri.parse(fcmUrl),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(mensaje),
//     );

//     if (response.statusCode == 200) {
//       //print("Notificación enviada exitosamente");
//     } else {
//       //print("Error al enviar la notificación: ${response.body}");
//     }
//   }

//   //notificar a un usuario especifico
//   Future<void> sendNotificationToUser(
//       String userToken, String title, String body, String? imageUrl) async {
//     final accountCredentials = ServiceAccountCredentials.fromJson(
//         json.decode(await rootBundle.loadString(serviceAccountPath)));

//     final client = await clientViaServiceAccount(accountCredentials, scopes);
//     final mensaje = {
//       "message": {
//         "token": userToken,
//         "notification": {
//           "title": title,
//           "body": body,
//         },
//         "data": {
//           "title": title,
//           "body": body,
//           "click_action": "FLUTTER_NOTIFICATION_CLICK",
//         }
//       }
//     };

//     if (imageUrl != null) {
//       mensaje['message']?['data'] ??= {};
//       (mensaje['message']?['data'] as Map<String, dynamic>)['image'] = imageUrl;
//     }

//     final response = await client.post(
//       Uri.parse(fcmUrl),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(mensaje),
//     );

//     if (response.statusCode == 200) {
//       //print("Notificación enviada exitosamente");
//     } else {
//       //print("Error al enviar la notificación: ${response.body}");
//     }
//   }

//   //notificar a los usuarios administradores
//   Future<void> sendNotificationToConductores(
//       String title, String body, String? imageUrl) async {
//     final accountCredentials = ServiceAccountCredentials.fromJson(
//         json.decode(await rootBundle.loadString(serviceAccountPath)));

//     final client = await clientViaServiceAccount(accountCredentials, scopes);
//     final QuerySnapshot<Map<String, dynamic>> adminUsersSnapshot =
//         await FirebaseFirestore.instance
//             .collection('users')
//             .where('conductor', isEqualTo: true)
//             .get();

//     final List<String> adminTokens = [];

//     for (var userDoc in adminUsersSnapshot.docs) {
//       final String token = userDoc.data()['token'] as String;
//       adminTokens.add(token);
//     }

//     final mensaje = {
//       "message": {
//         "token": adminTokens, // Aquí usamos los tokens de los administradores
//         "notification": {
//           "title": title,
//           "body": body,
//         },
//         "data": {
//           "title": title,
//           "body": body,
//           "click_action": "FLUTTER_NOTIFICATION_CLICK",
//         }
//       }
//     };

//     if (imageUrl != null) {
//       mensaje['message']?['data'] ??= {};
//       (mensaje['message']?['data'] as Map<String, dynamic>)['image'] = imageUrl;
//     }

//     final response = await client.post(
//       Uri.parse(fcmUrl),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(mensaje),
//     );

//     if (response.statusCode == 200) {
//       // print("Notificación enviada exitosamente a los administradores");
//     } else {
//       // print("Error al enviar la notificación: ${response.body}");
//     }
//   }

//   //notificar a los usuarios administradores
//   Future<void> sendNotificationToAdminUsers(
//       String title, String body, String? imageUrl) async {
//     final accountCredentials = ServiceAccountCredentials.fromJson(
//         json.decode(await rootBundle.loadString(serviceAccountPath)));

//     final client = await clientViaServiceAccount(accountCredentials, scopes);
//     final QuerySnapshot<Map<String, dynamic>> adminUsersSnapshot =
//         await FirebaseFirestore.instance
//             .collection('users')
//             .where('rol', isEqualTo: 'admin')
//             .get();

//     final List<String> adminTokens = [];

//     for (var userDoc in adminUsersSnapshot.docs) {
//       final String token = userDoc.data()['token'] as String;
//       adminTokens.add(token);
//     }

//     final mensaje = {
//       "message": {
//         "token": adminTokens, // Aquí usamos los tokens de los administradores
//         "notification": {
//           "title": title,
//           "body": body,
//         },
//         "data": {
//           "title": title,
//           "body": body,
//           "click_action": "FLUTTER_NOTIFICATION_CLICK",
//         }
//       }
//     };

//     if (imageUrl != null) {
//       mensaje['message']?['data'] ??= {};
//       (mensaje['message']?['data'] as Map<String, dynamic>)['image'] = imageUrl;
//     }

//     final response = await client.post(
//       Uri.parse(fcmUrl),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(mensaje),
//     );

//     if (response.statusCode == 200) {
//       // print("Notificación enviada exitosamente a los administradores");
//     } else {
//       // print("Error al enviar la notificación: ${response.body}");
//     }
//   }

//   static closeStream() {
//     _messageStreamController.close();
//   }
// }
