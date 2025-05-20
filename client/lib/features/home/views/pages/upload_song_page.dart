import 'package:client/core/theme/app_pallet.dart';
import 'package:client/core/widgets/custom_textfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final songNameController = TextEditingController();
  final artistNameController = TextEditingController();
  Color selectedColor = Pallete.cardColor;

  @override
  void dispose() {
    songNameController.dispose();
    artistNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Upload Song"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.check),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                DottedBorder(
                  color: Pallete.borderColor,
                  dashPattern: const [10, 4],
                  radius: const Radius.circular(10),
                  borderType: BorderType.RRect,
                  strokeCap: StrokeCap.round,
                  child: const SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_open,
                          size: 40,
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Select a thumbnail",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                CustomTextfield(
                  hintText: "Pick a song",
                  controller: null,
                  readOnly: true,
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                CustomTextfield(
                  hintText: 'Artist',
                  controller: artistNameController,
                ),
                const SizedBox(height: 20),
                CustomTextfield(
                  hintText: 'Song Name',
                  controller: songNameController,
                ),
                const SizedBox(height: 20),
                // ColorPicker(
                //   pickersEnabled: const {
                //     ColorPickerType.wheel: true,
                //   },
                //   color: selectedColor,
                //   onColorChanged: (Color chanagedColor) {
                //     setState(() {
                //       selectedColor = chanagedColor;
                //     });
                //   },
                // ),
              ],
            ),
          ),
        ));
  }
}
