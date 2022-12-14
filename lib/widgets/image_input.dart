import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function(File) onSelectImage;
  const ImageInput({super.key, required this.onSelectImage});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  dynamic _pickImageError;
  final ImagePicker picker = ImagePicker();

  Future<void> getImage(ImageSource source, BuildContext ctx) async {
    final pickedFile = await picker.pickImage(source: source, maxWidth: 600);
    try {
      setState(() {
        if (pickedFile != null) {
          _storedImage = File(pickedFile.path);
        } else {
          print('No image selected.');
          Navigator.pop(ctx);
          return;
        }
      });
      //SALVO
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(pickedFile!.path);
      //* copy returns a Future
      final savedImage = await _storedImage?.copy('${appDir.path}/$fileName');
      widget.onSelectImage(savedImage!);

      if (!mounted) return; //! esci se widget non mounted
      Navigator.pop(ctx);
    } catch (error) {
      setState(() {
        _pickImageError = error;
        throw Exception();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        //button tiene il resto dello spazio:
        Expanded(
            child: TextButton.icon(
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary),
                onPressed: () async {
                  //*open the device's camera
                  //flutter d?? bridge alle features del sistema operativo
                  await showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Choose an Image'),
                      content: const Text(
                          "choose the image from gallery or snap a photo"),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextButton(
                            onPressed: () {
                              getImage(ImageSource.gallery, ctx);
                            },
                            child: const Text('Gallery'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextButton(
                            onPressed: () {
                              getImage(ImageSource.camera, ctx);
                            },
                            child: const Text('Camera'),
                          ),
                        )
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.camera),
                label: const Text('Take Picture')))
      ],
    );
  }
}
