import 'package:abjatenant/utils/local_storage.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

notify(header, text, status) async {
  print('notify is $status');
  await saveToken(status);
  //show notification
  AwesomeNotifications().createNotification(
      content: NotificationContent(
    //simgple notification
    id: 1,
    channelKey: 'request', //set configuration wuth key "basic"
    title: header,
    body: text,
  ));
}
