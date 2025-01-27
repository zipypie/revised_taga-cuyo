import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/constants/capitalize.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/fonts.dart';
import '../../../core/cubit/category_cubit/category_cubit.dart';
import '../../../core/repositories/category_repository.dart/src/firestore_user_progress_repository.dart';
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
      create: (_) => CategoryCubit(FirebaseCategoryRepository())
        ..fetchCategories(), // Fetch categories immediately
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
    return ListView.builder(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];

        return CategoryTile(category: category);
      },
    );
  }
}

class CategoryTile extends StatelessWidget {
  final CategoryModel category;

  const CategoryTile({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SubcategoryModel>>(
      future: FirebaseCategoryRepository().getSubcategories(category.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No subcategories available');
        }

        final subcategories = snapshot.data!;

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
              TopCategoryCard(category: category),
              SubcategoriesSlider(subcategories: subcategories),
            ],
          ),
        );
      },
    );
  }
}

class TopCategoryCard extends StatelessWidget {
  final CategoryModel category;

  const TopCategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            capitalizeFirstLetter(category.categoryName),
            style: TextStyles.h2b,
          ),
          Text(
            '0/4', // Hardcoded value, can be dynamically fetched later
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
      margin: const EdgeInsets.only(right: 20, top: 15),
      height: ScreenUtils.getScreenHeight(context, subtract: 394) / 3,
      width: (ScreenUtils.getScreenWidth(context) - 80) / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          subcategory.imagePath.isNotEmpty
              ? Container(
                  height:
                      ScreenUtils.getScreenHeight(context, subtract: 550) / 3,
                  decoration: BoxDecoration(
                    color: Colors.white, // White background for images
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset:
                            Offset(0, 5), // Subtle shadow effect for elevation
                      ),
                    ],
                  ),
                  clipBehavior: Clip
                      .hardEdge, // Ensure the child image stays within rounded corners
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      subcategory.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child:
                              Icon(Icons.image, size: 50, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                )
              : Container(
                  height:
                      ScreenUtils.getScreenHeight(context, subtract: 550) / 3,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBackground,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4), // Subtle shadow for fallback
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(Icons.image,
                        size: 50, color: Colors.grey), // Fallback icon styled
                  ),
                ),
          SizedBox(height: 8),
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
