import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/common_widgets/popup%20displays/snackbar.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/button.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import '../../../../core/cubit/category_cubit/category_cubit.dart';

class ReportScreen extends StatefulWidget {
  final String userId;
  final String categoryName;
  final String subcategoryName;
  final String wordId;

  const ReportScreen({
    super.key,
    required this.userId,
    required this.categoryName,
    required this.subcategoryName,
    required this.wordId,
  });

  @override
  ReportScreenState createState() => ReportScreenState();
}

class ReportScreenState extends State<ReportScreen> {
  int _selectedReason = -1; // Default to no selection
  final List<String> reportReasons = [
    "Incorrect translation.",
    "There is a typo.",
    "The question is unclear.",
    "There is something wrong with the UI."
  ];

  void _onChanged(int? value) {
    if (value != null) {
      setState(() {
        _selectedReason = value;
      });
    }
  }

  static void showReport(
    BuildContext context,
    String userId,
    String categoryName,
    String subcategoryName,
    String wordId,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReportScreen(
          userId: userId,
          categoryName: categoryName,
          subcategoryName: subcategoryName,
          wordId: wordId,
        );
      },
    );
  }

  void _submitReport() {
    if (_selectedReason == -1) {
      showSnackBar(context, 'Please select a reason');
      return;
    }

    String selectedReason = reportReasons[_selectedReason];

    // Close the dialog before showing further snackbars
    Navigator.pop(context);

    context.read<CategoryCubit>().submitReport(
          widget.userId,
          widget.categoryName,
          widget.subcategoryName,
          widget.wordId,
          selectedReason,
        );

    showSnackBar(context, 'Report submitted successfully');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text(
          "Report Question",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Center(
              child: Text(
                "Select the reason for reporting this question",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            ...reportReasons.asMap().entries.map((entry) {
              return Container(
                color: AppColors.accentColor,
                margin: const EdgeInsets.all(5),
                child: RadioListTile<int>(
                  value: entry.key,
                  groupValue: _selectedReason,
                  title: Text(entry.value),
                  onChanged: _onChanged,
                  activeColor: Theme.of(context).primaryColor,
                ),
              );
            }),
          ],
        ),
      ),
      actions: [
        CustomButton(
          onTab: _submitReport,
          text: 'Submit Report',
        ),
        CustomButton(
          onTab: () => Navigator.pop(context),
          backgroundColor: Colors.transparent,
          text: 'Cancel',
        ),
      ],
    );
  }
}
