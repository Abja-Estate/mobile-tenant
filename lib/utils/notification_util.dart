import 'package:awesome_notifications/awesome_notifications.dart';

notify(header,text) async {
 

    //show notification
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      //simgple notification
      id: 123,
      channelKey: 'basic', //set configuration wuth key "basic"
      title: header,
      body: text,
    ));
  
}
