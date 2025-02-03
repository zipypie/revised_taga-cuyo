import 'models/categories_model.dart';
import 'models/subcategories_model.dart';
import 'models/words_model.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>> getCategories();

  Future<List<SubcategoryModel>> getSubcategories(String categoryId);

  Future<List<WordsModel>> getWords(
      String categoryDocId, String subcategoryDocId);

  Future<int> countWords(String categoryDocId, String subcategoryDocId);

  Future<void> submitReport(String userId, String categoryName,
      String subcategoryName, String wordId, String reportReason);
}
