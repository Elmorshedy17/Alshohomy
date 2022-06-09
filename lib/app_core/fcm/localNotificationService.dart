
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

////////////////////////////////////////////////////////////////////////////////
// LocalNotification
////////////////////////////////////////////////////////////////////////////////

class LocalNotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initializeLocalNotification() async {
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/notifications_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    // final MacOSInitializationSettings initializationSettingsMacOS =
    // MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void showNotification(
    title,
    body,
    id,
  ) async {
    var android = const AndroidNotificationDetails('channelId', 'channelName',
        channelDescription: 'channelDescription',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false);
    var ios = const IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);
    await flutterLocalNotificationsPlugin.show(0, '$title', '$body', platform,
        payload: '$id');
  }

  Future onSelectNotification(String? payload) async {

    // if (payload != null) {
    //   if (int.parse(payload) != 0) {
    //     locator<NavigationService>().pushNamedTo(
    //       AppRouts.Order_History_Page,
    //       // arguments: OrderDetailsPageArgs(
    //       //   orderId: int.parse(payload),
    //       // ),
    //     );
    //   }
    // }

    // if (locator<FcmTokenManager>().notificationType == "my_stars") {
    //       locator<NavigationService>().pushNamedTo(
    //         AppRoutesNames.MyStarsPage,
    //       );
    //
    // }else if(locator<FcmTokenManager>().notificationType == "order"){
    //   locator<NavigationService>().pushNamedTo(
    //     AppRoutesNames.OrderDetailsPage,
    //     arguments: OrderDetailsPageArgs(orderId: int.parse("$payload")),
    //   );
    // }else if(locator<FcmTokenManager>().notificationType == "star"){
    //   locator<NavigationService>().pushNamedTo(
    //     AppRoutesNames.StarDetailsPage,
    //       arguments: StarDetailsArgs(
    //         starDetailsRequest: StarDetailsRequest(starId:"$payload",))
    //   );
    // }



  }

  Future onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title),
    //     content: Text(body),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           await Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => SecondScreen(payload),
    //             ),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );
  }
}
