import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/common_widgets/terms%20and%20condition/terms_text.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';

class TermsAndCondition extends StatefulWidget {
  final bool onShowRow; // Non-nullable bool with a default value

  const TermsAndCondition(
      {super.key, this.onShowRow = false}); // Default to false

  @override
  TermsAndConditionState createState() => TermsAndConditionState();
}

class TermsAndConditionState extends State<TermsAndCondition> {
  late bool _showRow;

  @override
  void initState() {
    super.initState();
    // Set the initial state based on the flag passed from the parent
    _showRow = widget.onShowRow;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TermsText.title, style: TextStyles.termsTitle),
        backgroundColor: AppColors.primaryBackground,
        automaticallyImplyLeading: false,
        leading: !_showRow
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : null, // Show back button only when _showRow is true
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TermsText.introduction, style: TextStyles.termsContent),
              Text(TermsText.section1Title,
                  style: TextStyles.termsSectionTitle),
              Text(TermsText.section1Content, style: TextStyles.termsContent),
              Text(TermsText.section2Title,
                  style: TextStyles.termsSectionTitle),
              Text(TermsText.section2Content, style: TextStyles.termsContent),
              Text(TermsText.section3Title,
                  style: TextStyles.termsSectionTitle),
              Text(TermsText.section3Content, style: TextStyles.termsContent),
              Text(TermsText.section4Title,
                  style: TextStyles.termsSectionTitle),
              Text(TermsText.section4Content, style: TextStyles.termsContent),
              if (_showRow) // Only show the Row when _showRow is true
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Cancel button
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.wrong,
                          foregroundColor: AppColors.titleColor,
                        ),
                        child: Text('Cancel',
                            style: TextStyle(
                                fontSize: 19,
                                fontFamily: AppFonts.fcr,
                                fontWeight: FontWeight.bold)),
                      ),
                      // Agree button
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.primaryBackground,
                        ),
                        child: Text('Agree',
                            style: TextStyle(
                                fontSize: 19,
                                fontFamily: AppFonts.fcr,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
