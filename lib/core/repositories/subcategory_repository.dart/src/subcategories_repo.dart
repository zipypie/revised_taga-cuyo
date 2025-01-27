import 'models/subcategories_model.dart';

abstract class SubCategoryRepository {
  Future<List<SubcategoryModel>> getSubcategories(
      String categoryId); // Updated type
}
