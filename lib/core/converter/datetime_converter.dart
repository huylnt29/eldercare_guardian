import 'package:intl/intl.dart';

import '../constants/error_message.dart';

class DateTimeConverter {
  static String getDate(int? epochTime) {
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

  static String getHourMinute(int? epochTime) {
    if (epochTime != null) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(
        epochTime.toInt(),
      );
      final date = DateFormat('HH:mm').format(dateTime); // 23:59
      return date;
    } else {
      return ErrorMessage.isNotDetermined;
    }
  }

  static String getTimeFirstDateAfter(int? epochTime) {
    if (epochTime != null) {
      return '${getHourMinute(epochTime)}, ${getDate(epochTime)}';
    } else {
      return ErrorMessage.isNotDetermined;
    }
  }

  static String getDateInSchedule(int? epochTime) {
    if (epochTime != null) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(
        epochTime.toInt(),
      );
      return '${DateFormat('EEEE').format(dateTime)} (${getDate(epochTime)})';
    } else {
      return ErrorMessage.isNotDetermined;
    }
  }
}
