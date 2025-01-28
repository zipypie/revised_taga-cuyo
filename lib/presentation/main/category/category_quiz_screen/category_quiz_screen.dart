import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/button.dart';
import 'package:taga_cuyo/core/constants/capitalize.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/repositories/category_repository.dart/src/models/categories_model.dart';
import 'package:taga_cuyo/core/repositories/category_repository.dart/src/models/subcategories_model.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';
import '../../../../core/constants/fonts.dart';

class CategoryQuizScreen extends StatelessWidget {
  final SubcategoryModel subcategory;
  final CategoryModel category;

  const CategoryQuizScreen({
    super.key,
    required this.subcategory,
    required this.category,
  });

  final bool selectOptions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: ScreenUtils.getScreenWidth(context),
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    capitalizeFirstLetter(category.getCategoryName),
                    style: TextStyles.h2b.copyWith(color: AppColors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: ScreenUtils.getScreenHeight(context) * 0.01),
                  Text(
                    capitalizeFirstLetter(subcategory.subCategoryName),
                    style: TextStyles.h1b,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: ScreenUtils.getScreenHeight(context) * 0.35,
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Icon(Icons.image, size: 100),
                    ),
                  ),
                  SizedBox(height: ScreenUtils.getScreenHeight(context) * 0.01),
                  Text(capitalizeFirstLetter('word here'),
                      style: TextStyles.h1b),
                  SizedBox(
                      height: ScreenUtils.getScreenHeight(context) * 0.018),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.accentColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                        child: Text(
                      'Options 1',
                      style: TextStyles.h3r.copyWith(fontSize: 21),
                    )),
                  ),
                  SizedBox(
                      height: ScreenUtils.getScreenHeight(context) * 0.018),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.accentColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                        child: Text(
                      'Options 2',
                      style: TextStyles.h3r.copyWith(fontSize: 21),
                    )),
                  ),
                  SizedBox(
                      height: ScreenUtils.getScreenHeight(context) * 0.018),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.accentColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                        child: Text(
                      'Options 3',
                      style: TextStyles.h3r.copyWith(fontSize: 21),
                    )),
                  ),
                  SizedBox(
                      height: ScreenUtils.getScreenHeight(context) * 0.018),
                  CustomButton(onTab: () {}, text: 'Check Answer'),
                ],
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20, // Adjust the left and right margins
              child: Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 0.5,
                      backgroundColor: AppColors.grey,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.accentColor),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text('1/10'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
