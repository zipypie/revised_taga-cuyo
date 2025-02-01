import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/constants/capitalize.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';
import 'package:taga_cuyo/presentation/main/category/category_quiz_screen/category_quiz_screen.dart';
import '../../../core/bloc/authentication_bloc/authentication_bloc.dart';
import '../../../core/constants/fonts.dart';
import '../../../core/cubit/category_cubit/category_cubit.dart';
import '../../../core/repositories/category_repository.dart/src/firestore_user_progress_repository.dart';
import '../../../core/repositories/category_repository.dart/src/models/models.dart';
import '../../../core/repositories/category_repository.dart/src/models/subcategories_model.dart';
import '../../../core/repositories/user_progress_repository/src/firestore_user_progress_repository.dart';
import '../../../core/repositories/user_repository/src/firestore_user_repository.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the authenticated user's ID from the AuthenticationBloc
    final userId = context.select<AuthenticationBloc, String?>(
      (bloc) => bloc.state.user?.uid,
    );

    if (userId == null) {
      return const Center(child: Text('User not authenticated'));
    }

    return BlocProvider(
      create: (_) => CategoryCubit(
        FirebaseCategoryRepository(),
        FirebaseUserProgressRepository(
          userRepository: FirebaseUserRepository(),
        ),
        userId, // Pass the authenticated user's ID
      )..fetchCategoriesWithSubcategories(),
      child: const _CategoryView(),
    );
  }
}

class _CategoryView extends StatelessWidget {
  const _CategoryView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoriesWithSubcategoriesLoaded) {
          // New state
          return CategoryCard(categories: state.categoriesWithSubcategories);
        } else if (state is CategoryError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class CategoryCard extends StatelessWidget {
  final List<CategoryWithSubcategories> categories;

  const CategoryCard({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final categoryWithSubs = categories[index];
        return CategoryTile(
          category: categoryWithSubs.category,
          subcategories: categoryWithSubs.subcategories,
        );
      },
    );
  }
}

// Modified TopCategoryCard to remove FutureBuilder
class TopCategoryCard extends StatelessWidget {
  final CategoryModel category;
  final int subcategoryCount;

  const TopCategoryCard({
    super.key,
    required this.category,
    required this.subcategoryCount,
  });

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
            '0/$subcategoryCount',
            style: TextStyles.h3b,
          ),
        ],
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final CategoryModel category;
  final List<SubcategoryModel> subcategories;

  const CategoryTile({
    super.key,
    required this.category,
    required this.subcategories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtils.getScreenHeight(context, subtract: 154) / 3,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 225, 225, 225),
            width: 3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopCategoryCard(
            category: category,
            subcategoryCount: subcategories.length,
          ),
          SubcategoriesSlider(subcategories: subcategories, category: category),
        ],
      ),
    );
  }
}

class SubcategoriesSlider extends StatelessWidget {
  final List<SubcategoryModel> subcategories;
  final CategoryModel category;

  const SubcategoriesSlider(
      {super.key, required this.subcategories, required this.category});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: subcategories.map((subcategory) {
            return SubcategoryCard(
                subcategory: subcategory, category: category);
          }).toList(),
        ),
      ),
    );
  }
}

class SubcategoryCard extends StatelessWidget {
  final CategoryModel category;
  final SubcategoryModel subcategory;
  final Map<String, String> _imageCache = {};

  SubcategoryCard({
    super.key,
    required this.subcategory,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CategoryCubit>();
    final cachedImage = _imageCache[subcategory.imagePath];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryQuizScreen(
              category: category,
              subcategory: subcategory,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20, top: 15),
        height: ScreenUtils.getScreenHeight(context, subtract: 394) / 3,
        width: (ScreenUtils.getScreenWidth(context) - 80) / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: ScreenUtils.getScreenHeight(context, subtract: 550) / 3,
              width: (ScreenUtils.getScreenWidth(context) - 80) / 3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              clipBehavior: Clip.hardEdge,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: cachedImage != null
                    ? Image.network(cachedImage, fit: BoxFit.cover)
                    : FutureBuilder<String?>(
                        future: cubit.getDownloadableUrl(subcategory.imagePath),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            _imageCache[subcategory.imagePath] = snapshot.data!;
                            return Image.network(
                              snapshot.data!,
                              fit: BoxFit.cover,
                            );
                          }
                          return const Center(
                            child:
                                Icon(Icons.image, size: 50, color: Colors.grey),
                          );
                        },
                      ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              capitalizeFirstLetter(subcategory.subCategoryName),
              textAlign: TextAlign.center,
              style: TextStyles.h4n.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
