import 'package:eldercare_guardian/core/enums/task_status.dart';
import 'package:flutter/material.dart';

class AppColors {
  AppColors._internall();

  static const Color primaryColor = Color(0xFFF5EFE7);
  static const Color secondaryColor = Color(0xFFACD2ED);
  static const Color accentColor = Color(0xFF14591D);
  static const Color textColor = Color.fromARGB(255, 41, 40, 40);
  static const Color disableBackgroundColor = Color(0xFFD9D9D9);
  static const Color paleSilverBackgroundColor = Color(0xFFD8C4B6);

  static const Color taskStatusNotDoneColor = Color.fromARGB(255, 52, 132, 143);
  static const Color taskStatusCancelledColor = Color.fromARGB(255, 74, 77, 75);
  static const Color taskStatusPendingColor = Color.fromARGB(255, 115, 127, 28);
  static const Color taskStatusDoneColor = Color.fromARGB(255, 78, 154, 104);
  static const Color taskStatusLateColor = Color.fromARGB(255, 98, 77, 27);
  static const Color taskStatusOverdueColor = Color.fromARGB(255, 119, 40, 40);

  static Color getColorBasedOnTaskStatus(TaskStatus taskStatus) {
    switch (taskStatus) {
      case TaskStatus.notDone:
        return taskStatusNotDoneColor;
      case TaskStatus.cancelled:
        return taskStatusCancelledColor;
      case TaskStatus.late:
        return taskStatusLateColor;
      case TaskStatus.overdue:
        return taskStatusOverdueColor;
      case TaskStatus.pending:
        return taskStatusPendingColor;
      case TaskStatus.done:
        return taskStatusDoneColor;
      default:
        return secondaryColor;
    }
  }
}
