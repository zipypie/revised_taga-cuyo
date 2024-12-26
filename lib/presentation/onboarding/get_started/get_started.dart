import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/app/routes/routes.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/core/constants/images.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';
import 'get_started_cubit.dart'; // Import your cubit

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  final List<Map<String, dynamic>> pages = [
    {
      'title': 'Learn Languages',
      'text':
          'Discover the richness of languages and expand your knowledge of Tagalog and Cuyonon.',
      'image': LocalImages.getStarted1,
      'button': 'Next Page',
    },
    {
      'title': 'Translate Instantly',
      'text': 'Quickly translate words and phrases for better communication!',
      'image': LocalImages.getStarted2,
      'button': 'Next Page',
    },
    {
      'title': 'Track Your Progress',
      'text': 'Monitor your learning progress and see your achievements!',
      'image': LocalImages.getStarted3,
      'button': 'Get Started',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetStartedCubit(pages.length),
      child: BlocBuilder<GetStartedCubit, int>(
        builder: (context, currentPage) {
          final cubit = context.read<GetStartedCubit>();

          return Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      /// Image
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Image.asset(
                            pages[currentPage]['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      /// Content
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 25),
                          color: AppColors.secondaryBackground,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: ScreenUtils.getScreenHeight(context) *
                                      0.025),

                              /// Title
                              Text(
                                pages[currentPage]['title'],
                                textAlign: TextAlign.center,
                                style: TextStyles.h1b,
                              ),
                              SizedBox(
                                  height: ScreenUtils.getScreenHeight(context) *
                                      0.025),

                              /// Content Text
                              Text(
                                pages[currentPage]['text'],
                                textAlign: TextAlign.center,
                                style: TextStyles.knt18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// Navigation Button (Positioned at the bottom-right)
                  Positioned(
                    bottom: 50,
                    right: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (currentPage < pages.length - 1) {
                          cubit.nextPage();
                        } else {
                          Navigator.pushNamed(context, AppRoutes.loginScreen);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        pages[currentPage]['button'],
                        style: TextStyles.buttonDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Page Indicator
            bottomNavigationBar: Container(
              padding: const EdgeInsets.only(bottom: 20),
              color: AppColors.secondaryBackground,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: currentPage == index ? 20 : 10,
                    height: 12,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? AppColors.primary
                          : AppColors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
