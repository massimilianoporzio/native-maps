import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(
    String pickedTitle,
    File pickedImage,
  ) {
    //*create on device / database
    final uuid = Uuid();
    final newPace = Place(
        id: uuid.v4(), title: pickedTitle, location: null, image: pickedImage);
    _items.add(newPace);
    notifyListeners(); //NOTIFICO A TUITTI
  }
}
