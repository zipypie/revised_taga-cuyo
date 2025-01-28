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
        // Pass the Firestore document ID to the CategoryModel
        return CategoryModel.fromEntity(
          CategoryEntity.fromMap(
            doc.data() as Map<String, dynamic>,
            id: doc.id, // Adding document ID here
          ),
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to load categories: ${e.toString()}');
    }
  }

  @override
  Future<List<SubcategoryModel>> getSubcategories(String categoryDocId) async {
    try {
      final snapshot = await categoriesCollection
          .doc(categoryDocId)
          .collection('subcategories')
          .get();

      log('Subcategories for Category Doc ID $categoryDocId: ${snapshot.docs.length}');

      if (snapshot.docs.isEmpty) {
        log('No subcategories found for Category Doc ID $categoryDocId');
        return [];
      }

      return snapshot.docs.map((doc) {
        // Safely extract fields from the document
        final subCategoryId = doc.data()['subcategory_id']?.toString() ?? '';
        final subCategoryName =
            doc.data()['subcategory_name']?.toString() ?? 'Unknown';
        final imagePath = doc.data()['image_path']?.toString() ?? '';

        log('Subcategory data: $subCategoryId, $subCategoryName, $imagePath');

        return SubcategoryModel.fromEntity(
          SubcategoryEntity(
            subCategoryId: subCategoryId,
            subCategoryName: subCategoryName,
            imagePath: imagePath,
          ),
        );
      }).toList();
    } catch (e) {
      log('Error fetching subcategories for Category Doc ID $categoryDocId: $e');
      throw Exception('Failed to load subcategories for $categoryDocId');
    }
  }
}
