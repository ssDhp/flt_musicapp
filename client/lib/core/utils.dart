import 'dart:io';

import 'package:file_picker/file_picker.dart';
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

// pickImage
