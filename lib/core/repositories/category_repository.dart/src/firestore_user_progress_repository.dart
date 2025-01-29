import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'categories_repo.dart';
import 'entities/categories_entity.dart';
import 'models/categories_model.dart';
import 'models/subcategories_model.dart';
import 'models/words_model.dart';

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
        final data = doc.data() as Map<String, dynamic>?;

        if (data == null) {
          log('Subcategory data is null for document ID: ${doc.id}');
          throw Exception('Null data in subcategories');
        }

        log('Subcategory data: $data');

        return SubcategoryModel(
          id: doc.id, // Firestore document ID
          subCategoryId: data['subcategory_id']?.toString() ?? '',
          subCategoryName: data['subcategory_name']?.toString() ?? 'Unknown',
          imagePath: data['image_path']?.toString() ?? '',
        );
      }).toList();
    } catch (e, stackTrace) {
      log('Error fetching subcategories for Category Doc ID $categoryDocId: $e',
          stackTrace: stackTrace);
      throw Exception('Failed to load subcategories for $categoryDocId');
    }
  }

  @override
  Future<List<WordsModel>> getWords(
      String subcategoryDocId, String categoryDocId) async {
    try {
      // Query the words collection under the subcategory
      final snapshot = await categoriesCollection
          .doc(categoryDocId) // Start with the category document
          .collection('subcategories') // Go to the subcategories collection
          .doc(subcategoryDocId) // Use the subcategory document ID
          .collection('words') // Now query the words collection
          .get();

      final words = snapshot.docs.map((doc) {
        final wordId = doc.id;
        final word = doc.data()['word']?.toString() ?? '';
        final translated = doc.data()['translated']?.toString() ?? '';
        final imagePath = doc.data()['image_path']?.toString() ?? '';
        final options = List<String>.from(doc.data()['options'] ?? []);

        return WordsModel(
          wordId: wordId,
          word: word,
          translated: translated,
          imagePath: imagePath,
          options: options,
        );
      }).toList();

      return words;
    } catch (e) {
      log('Error fetching words for Subcategory Doc ID $subcategoryDocId: $e');
      throw Exception('Failed to load words for $subcategoryDocId');
    }
  }

  @override
  Future<int> countWords(String categoryDocId, String subcategoryDocId) async {
    try {
      final snapshot = await categoriesCollection
          .doc(categoryDocId)
          .collection('subcategories')
          .doc(subcategoryDocId)
          .collection('words') // Targeting the words collection
          .get();

      final wordCount = snapshot.docs.length;

      log('Word count for Subcategory Doc ID $subcategoryDocId: $wordCount');

      return wordCount; // Return the total number of words
    } catch (e) {
      log('Error counting words for Subcategory Doc ID $subcategoryDocId: $e');
      throw Exception('Failed to count words for $subcategoryDocId');
    }
  }
}
