import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nativemaps/helpers/db_helper.dart';
import 'package:uuid/uuid.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

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
    DBHelper.insert('user_places', {
      //*le chiavi della mappa devono essere == alle colonne su DB
      'id': newPace.id,
      'title': newPace.title,
      'image': newPace.image.path
    });
  }

  Future<void> fetchAndSetPlaecs() async {
    final dataList = await DBHelper.getData("user_places");
    _items = dataList
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']), //create File from that path
            location: null))
        .toList();
    notifyListeners();
  }
}
