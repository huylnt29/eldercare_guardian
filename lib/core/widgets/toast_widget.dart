import 'package:fluttertoast/fluttertoast.dart';

import '../theme/app_colors.dart';

class ToastWidget {
  static Future<bool?> show(text) {
    return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      textColor: AppColors.primaryColor,
      fontSize: 16.0,
    );
  }
}
