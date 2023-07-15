import 'package:intl/intl.dart';

import '../constants/error_message.dart';

class DateTimeConverter {
  static String getDate(double? epochTime) {
    if (epochTime != null) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(
        epochTime.toInt(),
      );
      final date = DateFormat.yMMMMd('en_US').format(dateTime); // July 14, 2023
      return date;
    } else {
      return ErrorMessage.isNotDetermined;
    }
  }

  static String getHourMinute(double? epochTime) {
    if (epochTime != null) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(
        epochTime.toInt(),
      );
      final date = DateFormat('HH:mm').format(dateTime); // July 14, 2023
      return date;
    } else {
      return ErrorMessage.isNotDetermined;
    }
  }

  static String getTimeFirstDateAfter(double? epochTime) {
    if (epochTime != null) {
      return '${getHourMinute(epochTime)}, ${getDate(epochTime)}';
    } else {
      return ErrorMessage.isNotDetermined;
    }
  }
}
