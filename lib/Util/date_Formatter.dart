import 'package:intl/intl.dart';

String dateFormatted() {
  var now = DateTime.now();
  var formatter = new DateFormat("EEE,MMM d,'yy'");
  String formatteed = formatter.format(now);
  return formatteed;
}
