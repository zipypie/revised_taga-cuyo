import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/core/constants/strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            _header1(context),
            SizedBox(height: 12),
            _subTitle1(),
            _festivalImages()
          ],
        ),
      ),
    );
  }

  Widget _header1(BuildContext context) {
    return Center(
      child: Text(
        AppString.hh1,
        style: TextStyles.heading1,
      ),
    );
  }

  Widget _subTitle1() {
    return Align(
        alignment: Alignment.topLeft,
        child: Text(AppString.hsub1, style: TextStyles.heading4));
  }

  Widget _festivalImages() {
    return Center(
      child: Text('data'),
    );
  }
}
