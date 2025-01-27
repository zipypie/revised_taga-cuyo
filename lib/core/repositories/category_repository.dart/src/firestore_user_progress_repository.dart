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
          .doc(categoryDocId) // Using the category document ID here
          .collection('subcategories')
          .get();

      log('Subcategories for Category Doc ID $categoryDocId: ${snapshot.docs.length}');

      if (snapshot.docs.isEmpty) {
        log('No subcategories found for Category Doc ID $categoryDocId');
        return [];
      }

      return snapshot.docs.map((doc) {
        // Safely extract fields from the document, providing fallback values if needed
        final subcategoryId = doc.data()['subcategory_id']?.toString() ??
            '0'; // Fallback to '0' if null or not a String
        final subcategoryName = doc.data()['subcategory_name']?.toString() ??
            'Unknown'; // Fallback to 'Unknown' if null
        final imagePath = doc.data()['image_path']?.toString() ??
            ''; // Fallback to empty string if null

        log('Subcategory data: $subcategoryId, $subcategoryName, $imagePath');

        return SubcategoryModel.fromEntity(
          SubcategoryEntity.fromMap(
            {
              'subcategories_id': subcategoryId,
              'subcategories_name': subcategoryName,
              'image_path': imagePath,
            },
            doc.id, // Firestore document ID for subcategory
          ),
        );
      }).toList();
    } catch (e) {
      log('Error fetching subcategories for Category Doc ID $categoryDocId: $e');
      throw Exception('Failed to load subcategories for $categoryDocId');
    }
  }
}
