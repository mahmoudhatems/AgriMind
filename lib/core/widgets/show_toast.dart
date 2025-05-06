import 'package:fluttertoast/fluttertoast.dart';
import 'package:happyfarm/core/utils/colors.dart';

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,

    timeInSecForIosWeb: 1,
    backgroundColor:
        ColorsManager.realWhiteColor, // Slight opacity for a smoother effect
    textColor: ColorsManager.textIconColor,
    fontSize: 16.0,
  );
}
