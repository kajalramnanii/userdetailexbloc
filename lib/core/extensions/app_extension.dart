import 'package:intl/intl.dart';

extension CustomDateTimeFormatting on DateTime {
  String toCustomFormattedString() {
    return DateFormat('dd-MM-yyyy').format(this);
  }
}
