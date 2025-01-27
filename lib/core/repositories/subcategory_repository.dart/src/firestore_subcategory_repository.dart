import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../subcategories_repository.dart';

class FirebaseSubCategoryRepository implements SubCategoryRepository {
  final CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');

  // Fetch subcategories under a specific category by categoryId
  @override
  Future<List<SubcategoryModel>> getSubcategories(String categoryId) async {
    try {
      final snapshot = await categoriesCollection
          .doc(categoryId) // Access the specific category document
          .collection(
              'subcategories') // Access the subcategories collection within the category
          .get();

      log('Subcategories for categoryId $categoryId: ${snapshot.docs.length}');
      if (snapshot.docs.isEmpty) {
        log('No subcategories found for categoryId $categoryId');
      }

      return snapshot.docs.map((doc) {
        // Pass the document data and ID to create a SubcategoryModel
        return SubcategoryModel.fromEntity(
          SubcategoryEntity.fromMap(
            doc.data(), // Map the subcategory fields to entity
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
