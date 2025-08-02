import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

String rgbToHex(Color color) =>
    '${color.red8bit.toRadixString(16).padLeft(2, '0')}${color.green8bit.toRadixString(16).padLeft(2, '0')}${color.blue8bit.toRadixString(16).padLeft(2, '0')}';

Color colorToHex(String hexCode) =>
    Color(int.parse(hexCode, radix: 16) + 0xFF000000);

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

Future<File?> pickAudio() async {
  try {
    final filePickerRes =
        await FilePicker.platform.pickFiles(type: FileType.audio);

    if (filePickerRes != null) {
      return File(filePickerRes.files.first.xFile.path);
    }

    return null;
  } catch (error) {
    return null;
  }
}

Future<File?> pickImage() async {
  try {
    final filePickerRes =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (filePickerRes != null) {
      return File(filePickerRes.files.first.xFile.path);
    }

    return null;
  } catch (error) {
    return null;
  }
}
