import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String snackBarText,
  Color? snackBarBackgroundColor,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(snackBarText),
        backgroundColor:
            snackBarBackgroundColor ?? Theme.of(context).colorScheme.onSurface,
      ),
    );
}
