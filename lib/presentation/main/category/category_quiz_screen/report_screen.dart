import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/button.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import '../../../../core/cubit/category_cubit/category_cubit.dart';

class ReportScreen extends StatefulWidget {
  final BuildContext parentContext;
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
    required this.parentContext,
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
          parentContext: context,
        );
      },
    );
  }

  void _submitReport() async {
    if (_selectedReason == -1) {
      // Show error dialog if no reason is selected
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'No Reason Selected',
              style: TextStyles.h1b,
            ),
            content: const Text(
              'Please select a reason for reporting the question.',
              style: TextStyles.h4n,
            ),
            actions: [
              CustomButton(onTab: () => Navigator.pop(context), text: 'OK')
            ],
          ),
        );
      }
      return;
    }

    String selectedReason = reportReasons[_selectedReason];

    try {
      // Submit the report
      await context.read<CategoryCubit>().submitReport(
            widget.userId,
            widget.categoryName,
            widget.subcategoryName,
            widget.wordId,
            selectedReason,
          );

      // Close the report dialog
      if (mounted) {
        Navigator.pop(context);
      }

      // Show success dialog
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Success',
              style: TextStyles.h1b,
            ),
            content: const Text(
              'Report submitted successfully!',
              style: TextStyles.h4n,
            ),
            actions: [
              CustomButton(onTab: () => Navigator.pop(context), text: 'OK')
            ],
          ),
        );
      }
    } catch (e) {
      // Close the report dialog on error
      if (mounted) {
        Navigator.pop(context);
      }

      // Show error dialog
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to submit report. Please try again.'),
            actions: [
              CustomButton(onTab: () => Navigator.pop(context), text: 'OK')
            ],
          ),
        );
      }
    }
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
      content: Column(
        mainAxisSize: MainAxisSize.min,
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
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: AppColors.accentColor,
                  borderRadius: BorderRadius.circular(15)),
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
