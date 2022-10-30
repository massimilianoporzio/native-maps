import 'package:nativemaps/env/env.dart';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=${Env.MAPSKEY}';
  }
}