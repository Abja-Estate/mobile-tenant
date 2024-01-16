import 'package:intl/intl.dart';

String formatMillisecondsToDateString(String milliseconds) {
  DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch(int.parse(milliseconds));
  return DateFormat('dd-MMM-yyyy hh:mm a').format(dateTime);
}

String formatTZDate(String inputDate) {
  // Parse the input date string
  DateTime dateTime = DateTime.parse(inputDate);

  // Format the date using intl package
  String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
  print(formattedDate);
  return formattedDate;
}
