import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'categories_repo.dart';
import 'entities/categories_entity.dart';
import 'entities/words_entity.dart';
import 'models/categories_model.dart';
import 'models/subcategories_model.dart';

class FirebaseCategoryRepository implements CategoryRepository {
  final CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');
  final CollectionReference subcategoriesCollection =
      FirebaseFirestore.instance.collection('subcategories');

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final snapshot = await categoriesCollection.get();

      log('Categories: ${snapshot.docs.length}');
      return snapshot.docs.map((doc) {
        return CategoryModel.fromEntity(
            CategoryEntity.fromMap(doc.data() as Map<String, dynamic>));
      }).toList();
    } catch (e) {
      throw Exception('Failed to load categories: ${e.toString()}');
    }
  }

  @override
  Future<List<SubcategoryModel>> getSubcategories(String categoryId) async {
    try {
      final snapshot = await subcategoriesCollection
          .where('categoryId', isEqualTo: categoryId)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return SubcategoryModel(
          subCategoryId: doc.id,
          subCategoryName: data['subCategoryName'] ?? '',
          words: (data['words'] as List<dynamic>).map((word) {
            return WordEntity.fromMap(
                word['wordId'] ?? '', word as Map<String, dynamic>);
          }).toList(),
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to load subcategories: ${e.toString()}');
    }
  }
}
