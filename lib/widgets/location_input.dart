import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:nativemaps/helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  Future<void> _getCurrentLocation() async {
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: locData.latitude, longitude: locData.longitude);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          child: _previewImageUrl == null
              ? const Text(
                  'No location chosen.',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.location_on),
                label: Text(
                  'Current Location',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                )),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map),
                label: Text(
                  'Select on the Map',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                )),
          ],
        )
      ],
    );
  }
}
