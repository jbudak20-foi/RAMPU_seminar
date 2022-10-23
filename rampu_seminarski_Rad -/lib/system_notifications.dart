import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationWidget {

  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future init({bool scheduled = false}) async {
    var initAndroidSettings = const AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = const DarwinInitializationSettings();
    final settings = InitializationSettings(android: initAndroidSettings, iOS: ios);
    await _notifications.initialize(settings);
  }

  static Future showNotification({
    var id = 0,
    var title,
    var body,
    var payload
  })async => _notifications.show(id, title, body, await notificationDetails());

  static notificationDetails() async{
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel ID',
          'channel name',
          importance: Importance.max,
          priority: Priority.max,
          styleInformation: BigTextStyleInformation(''), //tekst se može cijeli vidjeti u notifikaciji
        ),

        iOS: DarwinNotificationDetails(

        )
    );
  }
}


class ComplexNotifications {

  // ignore: non_constant_identifier_names
  static void NotifyMe() async{

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 123,
          channelKey: 'key1',
          title: 'Razvoj aplikacija',
          body: 'Dobrodošao na RAMPU. Ovo je moj seminarski rad u kojem se koristim Flutterom i alatima... Ako želiš znati više -> klikni Otvori',
          bigPicture: 'https://img.freepik.com/free-vector/laptop-with-program-code-isometric-icon-software-development-programming-applications-dark-neon_39422-971.jpg',
          notificationLayout: NotificationLayout.BigPicture,
        ),

        actionButtons: [
          NotificationActionButton(key: 'open', label: 'Otvori'),
          NotificationActionButton(key: 'delete', label: 'Obriši')
        ]
    );
  }

  // ignore: non_constant_identifier_names
  static void NotifyMeScheduled() async{

    String timezone = await AwesomeNotifications().getLocalTimeZoneIdentifier();

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 123,
          channelKey: 'key1',
          title: 'Razvoj aplikacija',
          body: 'Dobrodošao na RAMPU. Ovo je moj seminarski rad u kojem se koristim Flutterom i alatima... Ako želiš znati više -> klikni Otvori',
          bigPicture: 'https://img.freepik.com/free-vector/laptop-with-program-code-isometric-icon-software-development-programming-applications-dark-neon_39422-971.jpg',
          notificationLayout: NotificationLayout.BigPicture,
        ),

        actionButtons: [
          NotificationActionButton(key: 'open', label: 'Otvori'),
          NotificationActionButton(key: 'delete', label: 'Obriši'),
        ],

        schedule: NotificationInterval(interval: 5, timeZone: timezone, repeats: false)
    );
  }
}