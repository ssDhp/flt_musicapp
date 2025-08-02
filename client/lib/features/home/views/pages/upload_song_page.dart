import 'dart:io';

import 'package:client/core/theme/app_pallet.dart';
import 'package:client/core/utils.dart';
import 'package:client/core/widgets/custom_textfield.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/home/repositories/home_repository.dart';
import 'package:client/features/home/viewmodel/home_view_model.dart';
import 'package:client/features/home/views/widgets/audio_wave.dart';
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
  File? selectedImage;
  File? selectedAudio;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    songNameController.dispose();
    artistNameController.dispose();

    super.dispose();
  }

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  void selectAudio() async {
    final pickedAuido = await pickAudio();
    if (pickedAuido != null) {
      setState(() {
        selectedAudio = pickedAuido;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(homeViewModelProvider.select((val) => val?.isLoading == true));
    return Scaffold(
        appBar: AppBar(
          title: const Text("Upload Song"),
          actions: [
            IconButton(
              onPressed: () async {
                if (formKey.currentState!.validate() &&
                    selectedAudio != null &&
                    selectedImage != null) {
                  ref.read(homeViewModelProvider.notifier).uploadSong(
                        selectedAudio: selectedAudio!,
                        selectedThumbnail: selectedImage!,
                        songName: songNameController.text,
                        artist: artistNameController.text,
                        selectedColor: selectedColor,
                      );
                } else {
                  showSnackBar(
                      context: context,
                      snackBarText: 'Some of the fields are empty/invalid!');
                }
              },
              icon: Icon(Icons.check),
            )
          ],
        ),
        body: isLoading
            ? const Loader()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: selectImage,
                          child: selectedImage != null
                              ? SizedBox(
                                  width: double.infinity,
                                  height: 100,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadiusGeometry.circular(10),
                                    child: Image.file(
                                      selectedImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : DottedBorder(
                                  color: Pallete.borderColor,
                                  dashPattern: const [10, 4],
                                  radius: const Radius.circular(10),
                                  borderType: BorderType.RRect,
                                  strokeCap: StrokeCap.round,
                                  child: const SizedBox(
                                    height: 150,
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                        ),
                        const SizedBox(height: 40),
                        selectedAudio != null
                            ? AudioWave(path: selectedAudio!.path)
                            : CustomTextfield(
                                hintText: "Pick a song",
                                controller: null,
                                readOnly: true,
                                onTap: selectAudio,
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
                ),
              ));
  }
}
