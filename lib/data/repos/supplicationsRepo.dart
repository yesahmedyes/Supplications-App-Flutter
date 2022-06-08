import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supplications_app/data/models/category.dart';
import 'package:supplications_app/data/models/supplication.dart';

class SupplicationsRepo {
  final FirebaseFirestore _firestore;

  SupplicationsRepo() : _firestore = FirebaseFirestore.instance;

  final List<Category> _categories = [];
  final Map<String, List<Supplication>> _supplications = {};

  Future<List<Category>> fetchCategories() async {
    final _snapshot = await _firestore.collection("categories").get();

    for (var element in _snapshot.docs) {
      final id = element.id;
      final data = element.data();

      _categories.add(Category(categoryId: id, name: data['name'], image: data['image'], index: data['index']));
    }

    return _categories;
  }

  Future<List<Supplication>> fetchSupplications(String categoryId) async {
    if (!_supplications.containsKey(categoryId)) {
      _supplications[categoryId] = [];

      final _snapshot = await _firestore.collection("supplications").where("categoryId", isEqualTo: categoryId).get();

      for (var element in _snapshot.docs) {
        final id = element.id;
        final data = element.data();

        _supplications[categoryId]!.add(
          Supplication(
            supplicationId: id,
            audio: data['audio'],
            arabicText: data['arabicText'],
            englishTranslation: data['englishTranslation'],
            romanArabic: data['romanArabic'],
            categoryId: data['categoryId'],
            index: data['index'] ?? 0,
          ),
        );
      }
    }

    return _supplications[categoryId]!;
  }
}
