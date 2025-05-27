// import 'dart:convert';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:todo/config/config.dart';
// import 'package:todo/modules/chat/pages/chat_page.dart';
// import 'package:todo/modules/job_detail/pages/job_detail_page.dart';
//
// bool isAlreadyAtPostDetail = false;
//
// class LocalNotificationsApi {
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
//
//   LocalNotificationsApi(
//       {FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin})
//       : _flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin ??
//             FlutterLocalNotificationsPlugin();
//
//   ///create channel
//   AndroidNotificationChannel _channel = const AndroidNotificationChannel(
//     'app_channel', // id
//     'App Channel', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.high,
//   );
//
//   /// Initialize
//   Future<void> initialize() async {
//     await _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(_channel);
//     await _initSetting();
//   }
//
//   /// Show Notification
//   void showNotification(
//       RemoteMessage remoteMessage, AndroidNotification? android) async {
//     RemoteNotification? notification = remoteMessage.notification;
//
//     if (notification != null && android != null) {
//       AndroidNotificationDetails androidNotificationDetails =
//           AndroidNotificationDetails(
//         _channel.id,
//         _channel.name,
//         channelDescription: _channel.description,
//         importance: Importance.max,
//         priority: Priority.high,
//         ticker: 'ticker',
//       );
//       NotificationDetails notificationDetails =
//           NotificationDetails(android: androidNotificationDetails);
//       await _flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         notificationDetails,
//         payload: jsonEncode(remoteMessage.data),
//       );
//     }
//   }
//
//   /// Remove Notification
//   Future<void> removeNotification(int id) async {
//     await _flutterLocalNotificationsPlugin.cancel(id);
//   }
//
//   /// Initialize Settings
//   Future<void> _initSetting() async {
//     // android
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');
//
//     // darwin/IOS
//     final DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//       defaultPresentSound: true,
//       requestSoundPermission: true,
//       requestBadgePermission: true,
//       requestAlertPermission: true,
//       onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
//     );
//
//     // initializationSettings for Android/IOS
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsDarwin,
//     );
//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
//     );
//   }
//
//   /// For Darwin
//   void _onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) async {}
//
//   /// On select notification
//   void _onDidReceiveNotificationResponse(
//       NotificationResponse notificationResponse) async {
//     final String? payload = notificationResponse.payload;
//     if (notificationResponse.payload != null) {
//       Map<String, dynamic> json = jsonDecode(payload!);
//       PushNotificationModel notificationModel =
//           PushNotificationModel.fromJson(jsonDecode(json['data']));
//       if (notificationModel.type == 'offer' ||
//           notificationModel.type == 'job') {
//         if (isAlreadyAtPostDetail) {
//           NavRouter.toReplacement(
//               JobDetailPage(postId: notificationModel.post));
//         } else {
//           NavRouter.to(JobDetailPage(postId: notificationModel.post));
//         }
//       }
//       if (notificationModel.type == 'message') {
//         NavRouter.to(ChatPage(
//           receiverName: notificationModel.sender.firstName +
//               " " +
//               notificationModel.sender.lastName,
//           receiverImage: notificationModel.sender.profileImage,
//           receiverId: notificationModel.sender.id,
//           userId: notificationModel.receiver.id,
//         ));
//       }
//     }
//   }
// }
//
// class PushNotificationModel {
//   Receiver sender;
//   Receiver receiver;
//   String post;
//   String type;
//   String content;
//   String title;
//   bool read;
//   String id;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int v;
//
//   PushNotificationModel({
//     required this.sender,
//     required this.receiver,
//     required this.post,
//     required this.type,
//     required this.content,
//     required this.title,
//     required this.read,
//     required this.id,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//   });
//
//   factory PushNotificationModel.fromJson(Map<String, dynamic> json) =>
//       PushNotificationModel(
//         sender: Receiver.fromJson(json["sender"]),
//         receiver: Receiver.fromJson(json["receiver"]),
//         post: json["post"] ?? '',
//         type: json["type"],
//         content: json["content"],
//         title: json["title"] ?? '',
//         read: json["read"],
//         id: json["_id"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "sender": sender.toJson(),
//         "receiver": receiver.toJson(),
//         "post": post,
//         "type": type,
//         "content": content,
//         "title": title,
//         "read": read,
//         "_id": id,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//       };
// }
//
// class Receiver {
//   String id;
//   String firstName;
//   String lastName;
//   String profileImage;
//   String deviceId;
//
//   Receiver({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.profileImage,
//     required this.deviceId,
//   });
//
//   factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
//         id: json["_id"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         profileImage: json["profileImage"],
//         deviceId: json["deviceId"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "firstName": firstName,
//         "lastName": lastName,
//         "profileImage": profileImage,
//         "deviceId": deviceId,
//       };
// }
