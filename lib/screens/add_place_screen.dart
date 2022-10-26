import 'package:flutter/material.dart';
import 'package:nativemaps/widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();

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
                  const ImageInput()
                ],
              ),
            ))),
            const AddButton()
          ]),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,
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
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Add Place'));
  }
}
