import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

dynamic messageSnackBox({
  required BuildContext context,
  required String text,
  required int time,
}) {
  return showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.success(
      message: text,
    ),
    animationDuration: Duration(seconds: time),
  );
}

dynamic errorSnackBar({
  required BuildContext context,
  required String text,
  required int time,
}) {
  return showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.error(
      message: text,
    ),
    animationDuration: Duration(seconds: time),
  );
}
