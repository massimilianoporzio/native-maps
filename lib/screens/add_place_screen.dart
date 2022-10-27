import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nativemaps/providers/great_places.dart';
import 'package:nativemaps/widgets/image_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  late File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return; //esco subito (validazione)
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!);
    Navigator.of(context).pop(); //esco dalla pagina
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
        actions: const [],
      ),
      body: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                //alto come lo screen meno il bottone
                //*mi riempie lòa pagina e mette il bottone al fondo di conseguenza
                child: SingleChildScrollView(
                    //* la colonna puà scroll dentro
                    child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  //*NON USO VALIDATION NON USO FORM
                  TextField(
                    decoration: const InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ImageInput(
                    onSelectImage: _selectImage,
                  )
                ],
              ),
            ))),
            AddButton(
              onPressed: _savePlace,
            )
          ]),
    );
  }
}

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AddButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            foregroundColor: Colors.black,
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        onPressed: onPressed,
        icon: const Icon(Icons.add),
        label: const Text('Add Place'));
  }
}
