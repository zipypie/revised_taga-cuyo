import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taga_cuyo/core/repositories/category_repository.dart/src/user_progress_repo.dart';

class FirebaseCategoryRepository implements CategoryRepository {
  final categoriesCollection =
      FirebaseFirestore.instance.collection('categories');
}
