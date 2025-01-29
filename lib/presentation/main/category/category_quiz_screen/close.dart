import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class CloseScreen {
  static void showCloseBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Icon(
                  Icons.warning,
                  size: 100,
                  color: Colors.red,
                ),
              ),
              Text(
                'Are you sure you want to close the quiz?',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.wrong,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(); // Close the quiz screen
                    },
                    child: Text(
                      'End Session',
                      style: TextStyle(
                          color: AppColors.primaryBackground, fontSize: 16.0),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Return to Quiz',
                        style: TextStyle(
                            color: AppColors.titleColor, fontSize: 16.0)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
