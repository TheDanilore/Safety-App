// import 'dart:io';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> initNotification() async {
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('icon_notification');

//   DarwinInitializationSettings darwinInitializationSettings =
//       const DarwinInitializationSettings();

//   InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//     iOS: darwinInitializationSettings,
//   );

//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
// }

// // Mostrar notificación
// Future<void> mostrarNotificacion(String title, String body,
//     [String? image]) async {
//   const sound = "notification_sound.wav";

//   AndroidNotificationDetails androidNotificationDetails;

//   if (image != null && image.isNotEmpty) {
//     // Descargar la imagen desde la URL
//     final String imagePath = await _downloadAndSaveImage(image);

//     final BigPictureStyleInformation styleInformation =
//         BigPictureStyleInformation(
//       FilePathAndroidBitmap(imagePath),
//       largeIcon: FilePathAndroidBitmap(imagePath),
//       contentTitle: title,
//       htmlFormatContentTitle: true,
//       summaryText: body,
//       htmlFormatSummaryText: true,
//     );

//     androidNotificationDetails = AndroidNotificationDetails(
//       "channelId",
//       "channelName",
//       importance: Importance.max,
//       priority: Priority.high,
//       styleInformation: styleInformation,
//       sound: RawResourceAndroidNotificationSound(sound.split('.').first),
//       enableVibration: false,
//     );
//   } else {
//     androidNotificationDetails = AndroidNotificationDetails(
//       "channelId",
//       "channelName",
//       importance: Importance.max,
//       priority: Priority.high,
//       sound: RawResourceAndroidNotificationSound(sound.split('.').first),
//       enableVibration: false,
//     );
//   }

//   NotificationDetails notificationDetails = NotificationDetails(
//     android: androidNotificationDetails,
//   );

//   await flutterLocalNotificationsPlugin.show(
//     0,
//     title,
//     body,
//     notificationDetails,
//     payload: image,
//   );
// }

// Future<String> _downloadAndSaveImage(String imageUrl) async {
//   final Directory tempDir = await getTemporaryDirectory();
//   final String tempPath = tempDir.path;
//   final File file = File('$tempPath/image.jpg');
//   final http.Response response = await http.get(Uri.parse(imageUrl));
//   await file.writeAsBytes(response.bodyBytes);
//   return file.path;
// }
