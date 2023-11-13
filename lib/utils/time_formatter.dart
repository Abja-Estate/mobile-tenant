import 'package:intl/intl.dart';

String formatMillisecondsToDateString(String milliseconds) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(milliseconds));
  return DateFormat('dd-MMM-yyyy hh:mm a').format(dateTime);
}