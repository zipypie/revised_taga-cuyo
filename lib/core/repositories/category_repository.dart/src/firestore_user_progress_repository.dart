import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'categories_repo.dart';
import 'entities/categories_entity.dart';
import 'entities/subcategories_entity.dart';
import 'models/categories_model.dart';
import 'models/subcategories_model.dart';

class FirebaseCategoryRepository implements CategoryRepository {
  final CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');

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

  // Method to get categories by categoryId
  @override
  Future<List<CategoryModel>> getCategoriesById(String categoryId) async {
    try {
      final snapshot = await categoriesCollection
          .where('categoryId', isEqualTo: categoryId) // Filter by categoryId
          .get();

      log('Categories for ID $categoryId: ${snapshot.docs.length}');
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
      final snapshot = await categoriesCollection
          .doc(categoryId)
          .collection('subcategories')
          .get();

      log('Subcategories for categoryId $categoryId: ${snapshot.docs.length}');
      if (snapshot.docs.isEmpty) {
        log('No subcategories found for categoryId $categoryId');
      }
      return snapshot.docs.map((doc) {
        return SubcategoryModel.fromEntity(
          SubcategoryEntity.fromMap(
            doc.data(),
            doc.id, // Pass the document ID as subCategoryId
          ),
        );
      }).toList();
    } catch (e) {
      log('Error fetching subcategories: ${e.toString()}');
      throw Exception('Failed to load subcategories: ${e.toString()}');
    }
  }
}
