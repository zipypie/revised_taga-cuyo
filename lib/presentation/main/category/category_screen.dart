import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/fonts.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CategoryCard(),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtils.getScreenHeight(context, subtract: 155) / 3,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: const Color.fromARGB(255, 225, 225, 225), width: 3))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [TopCategoryCard(), SubcategoriesSlider()],
      ),
    );
  }
}

class TopCategoryCard extends StatelessWidget {
  const TopCategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Category Name',
            style: TextStyles.h2b,
          ),
          Text(
            '0/4',
            style: TextStyles.h3b,
          )
        ],
      ),
    );
  }
}

class SubcategoriesSlider extends StatelessWidget {
  const SubcategoriesSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            SubcategoryCard(),
            SubcategoryCard(),
            SubcategoryCard(),
            SubcategoryCard(),
          ],
        ),
      ),
    );
  }
}

class SubcategoryCard extends StatelessWidget {
  const SubcategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      height: ScreenUtils.getScreenHeight(context, subtract: 394) / 3,
      width: (ScreenUtils.getScreenWidth(context) - 80) / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: ScreenUtils.getScreenHeight(context, subtract: 550) / 3,
            decoration: BoxDecoration(
                color: AppColors.secondaryBackground,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(width: 10, color: AppColors.primary)),
          ),
          Text(
            'Subcategory Name',
            textAlign: TextAlign.center,
            style: TextStyles.h4n.copyWith(fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
