import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/core/constants/images.dart';
import 'package:taga_cuyo/core/constants/strings.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25),
              _header1(context),
              SizedBox(height: 15),
              _festivalSubtitle(),
              SizedBox(height: 25),
              _festivalImages(),
              SizedBox(height: 25),
              _destinationSubtitle(),
              SizedBox(height: 15),
              _destinationImages(),
            ],
          ),
        ),
      ),
    );
  }

// Custom header widget that displays a welcome message and an image
  Widget _header1(BuildContext context) {
    final width = ScreenUtils.getScreenWidth(context) - 150;
    final height = ScreenUtils.getScreenHeight(context);
    return Container(
      height: height * 0.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color.fromARGB(255, 255, 239, 216),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 40),
        child: Row(
          children: [
            SizedBox(
              width: width * 0.72,
              child: Text(
                'Welcome to Taga-Cuyo App', // Use \n to break the line
                style: TextStyle(
                  fontFamily: AppFonts.fcb,
                  fontSize: 24,
                  color: AppColors.titleColor,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.15,
              child: Image.asset(
                LocalImages.cashew1,
                fit: BoxFit
                    .cover, // Use BoxFit.cover to make the image cover the area
              ),
            )
          ],
        ),
      ),
    );
  }

// Displays the subtitle for the festival section
  Widget _festivalSubtitle() {
    return Align(
        alignment: Alignment.topLeft,
        child: Text(AppString.hsub1, style: TextStyles.h3b));
  }

// Displays a carousel of festival images with titles
  Widget _festivalImages() {
    final List<Map<String, String>> imagesWithTitles = [
      {'image': LocalImages.event1, 'title': 'Purongitan Festival'},
      {'image': LocalImages.event2, 'title': 'Ati-atihan Festival'},
    ];

    return FlutterCarousel(
      items: imagesWithTitles.map((item) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(item['image']!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColors.titleColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  item['title']!,
                  style: const TextStyle(
                    color: AppColors.primaryBackground,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        );
      }).toList(),
      options: FlutterCarouselOptions(
        height: 225,
        autoPlay: true,
        enableInfiniteScroll: true,
        enlargeCenterPage: true,
        slideIndicator: CircularSlideIndicator(
          slideIndicatorOptions: SlideIndicatorOptions(
            currentIndicatorColor: AppColors.primaryBackground,
            indicatorBackgroundColor: AppColors.accentColor,
            indicatorRadius: 6.0,
            itemSpacing: 15.0,
            enableHalo: true,
            haloDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.primary,
            ),
            haloPadding: EdgeInsets.all(4.0),
          ),
        ),
      ),
    );
  }

  // Displays the subtitle for the destination section
  Widget _destinationSubtitle() {
    return Align(
        alignment: Alignment.topLeft,
        child: Text(AppString.hsub2, style: TextStyles.h3b));
  }

  // Displays a carousel of destination images with titles
  Widget _destinationImages() {
    final List<Map<String, String>> imagesWithTitles = [
      {'image': LocalImages.destination1, 'title': 'Capusan Beach'},
      {
        'image': LocalImages.destination2,
        'title': 'St. Augustine Parish Church'
      },
    ];

    return FlutterCarousel(
      items: imagesWithTitles.map((item) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(item['image']!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColors.titleColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  item['title']!,
                  style: const TextStyle(
                    color: AppColors.primaryBackground,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        );
      }).toList(),
      options: FlutterCarouselOptions(
        height: 225,
        autoPlay: true,
        enableInfiniteScroll: true,
        enlargeCenterPage: true,
        slideIndicator: CircularSlideIndicator(
          slideIndicatorOptions: SlideIndicatorOptions(
            currentIndicatorColor: AppColors.primaryBackground,
            indicatorBackgroundColor: AppColors.accentColor,
            indicatorRadius: 6.0,
            itemSpacing: 15.0,
            enableHalo: true,
            haloDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.primary,
            ),
            haloPadding: EdgeInsets.all(4.0),
          ),
        ),
      ),
    );
  }
}
