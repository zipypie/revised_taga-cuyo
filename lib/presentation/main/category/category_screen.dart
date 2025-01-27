import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/constants/capitalize.dart';
import 'package:taga_cuyo/core/repositories/category_repository.dart/src/firestore_user_progress_repository.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/fonts.dart';
import '../../../core/cubit/category_cubit/category_cubit.dart';
import '../../../core/repositories/category_repository.dart/src/models/models.dart';
import '../../../core/repositories/category_repository.dart/src/models/subcategories_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CategoryCubit(FirebaseCategoryRepository())..fetchCategories(),
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoaded) {
            return CategoryCard(
                categories: state.categories); // Pass loaded categories
          } else if (state is CategoryError) {
            return Center(child: Text(state.message));
          }
          return Container(); // Default case
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final List<CategoryModel> categories;

  const CategoryCard({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    // Sort categories by `categoryId` for consistency
    final sortedCategories = List<CategoryModel>.from(categories)
      ..sort((a, b) => a.categoryId.compareTo(b.categoryId));

    return ListView.builder(
      shrinkWrap: true, // Adjusts to fit the content
      physics:
          AlwaysScrollableScrollPhysics(), // Prevents independent scrolling
      itemCount: sortedCategories.length, // Number of categories
      itemBuilder: (context, index) {
        final category = sortedCategories[index];

        return Container(
          height: ScreenUtils.getScreenHeight(context, subtract: 154) / 3,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: const Color.fromARGB(255, 225, 225, 225),
                width: 3,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopCategoryCard(
                categories: sortedCategories,
                categoryId: category.categoryId, // Pass current category ID
              ),
            ],
          ),
        );
      },
    );
  }
}

class TopCategoryCard extends StatelessWidget {
  final List<CategoryModel> categories;
  final int categoryId; // Keep as int

  const TopCategoryCard({
    super.key,
    required this.categories,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    // Find the category that matches the categoryId
    final category = categories.firstWhere(
      (cat) => cat.categoryId == categoryId,
      orElse: () => CategoryModel(
          categoryId: 0, categoryName: 'Unknown'), // Fallback if not found
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            capitalizeFirstLetter(category.categoryName), // Correct usage
            style: TextStyles.h2b,
          ),
          Text(
            '0/4',
            style: TextStyles.h3b,
          ),
        ],
      ),
    );
  }
}

class SubcategoriesSlider extends StatelessWidget {
  final List<SubcategoryModel> subcategories;

  const SubcategoriesSlider({super.key, required this.subcategories});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: subcategories.map((subcategory) {
            return SubcategoryCard(subcategory: subcategory);
          }).toList(),
        ),
      ),
    );
  }
}

class SubcategoryCard extends StatelessWidget {
  final SubcategoryModel subcategory;

  const SubcategoryCard({super.key, required this.subcategory});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      height: ScreenUtils.getScreenHeight(context, subtract: 394) / 3,
      width: (ScreenUtils.getScreenWidth(context) - 80) / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: ScreenUtils.getScreenHeight(context, subtract: 550) / 3,
            decoration: BoxDecoration(
              color: AppColors.secondaryBackground,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(width: 10, color: AppColors.primary),
            ),
          ),
          Text(
            capitalizeFirstLetter(subcategory.subCategoryName),
            textAlign: TextAlign.center,
            style: TextStyles.h4n.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
