import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:supplications_app/data/models/category.dart';
import 'package:supplications_app/data/models/supplication.dart';

class SupplicationsRepo {
  final FirebaseFirestore _firestore;

  SupplicationsRepo() : _firestore = FirebaseFirestore.instance;

  final List<Category> _categories = [];
  final Map<String, Map<String, Supplication>> _supplications = {};

  final _favoritesController = StreamController<Set<String>>();

  Stream<Set<String>> get favoritesStream => _favoritesController.stream;

  final Set<String> _favorites = {};

  Future<List<Category>> fetchCategories() async {
    if (_categories.isEmpty) {
      final _snapshot = await _firestore.collection("categories").get();

      for (var element in _snapshot.docs) {
        final id = element.id;
        final data = element.data();

        _categories.add(Category(categoryId: id, name: data['name'], image: data['image'], index: data['index']));
      }
    }

    return _categories;
  }

  Future<List<Supplication>> fetchSupplications(String categoryId) async {
    if (!_supplications.containsKey(categoryId)) {
      _supplications[categoryId] = {};

      final _snapshot = await _firestore.collection("supplications").where("categoryId", isEqualTo: categoryId).get();

      for (var element in _snapshot.docs) {
        final id = element.id;
        final data = element.data();

        Timestamp _timestamp = data['createdAt'];

        _supplications[categoryId]![id] = Supplication(
          supplicationId: id,
          audio: data['audio'],
          arabicText: data['arabicText'],
          englishTranslation: data['englishTranslation'],
          romanArabic: data['romanArabic'],
          categoryId: data['categoryId'],
          createdAt: DateTime.parse(_timestamp.toDate().toString()),
        );
      }
    }

    return _supplications[categoryId]!.values.toList();
  }

  Future<void> fetchFavorites() async {
    if (_favorites.isEmpty) await getFavorites();

    _favoritesController.sink.add(_favorites);
  }

  Future<List<Supplication>> fetchFavoriteSupplications() async {
    await fetchFavorites();
    await fetchCategories();

    List<Supplication> mySupplications = [];

    try {
      for (var each in _favorites) {
        List<String> temp = each.split(' ');
        String categoryId = temp[0];
        String supplicationId = temp[1];

        await fetchSupplications(categoryId);
        mySupplications.add(_supplications[categoryId]![supplicationId]!);
      }
    } catch (e) {
      return [];
    }

    return mySupplications;
  }

  Future<void> getFavorites() async {
    var box = await Hive.openBox('myBox');

    var values = box.get('favorites');

    if (values != null) {
      for (var element in (values as List)) {
        _favorites.add(element);
      }
    }
  }

  Future<void> putFavorites() async {
    var box = await Hive.openBox('myBox');

    box.put('favorites', _favorites.toList());
  }

  Future<void> toggleFavorite(String categoryId, String supplicationId) async {
    if (_favorites.isEmpty) await getFavorites();

    if (!_favorites.contains(categoryId + ' ' + supplicationId)) {
      _favorites.add(categoryId + ' ' + supplicationId);
    } else {
      _favorites.remove(categoryId + ' ' + supplicationId);
    }

    _favoritesController.sink.add(_favorites);

    await putFavorites();
  }
}
