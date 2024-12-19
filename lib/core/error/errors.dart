import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/common_widgets/alert_dialog.dart';

class ErrorHandler {
  static void handleError(BuildContext context, String errorType,
      {String errorMessage = ''}) {
    String title = '';
    String message = '';

    switch (errorType) {
      case 'missing_name':
        title = 'Kulang na Impormasyon';
        message = 'Mangyaring ilagay ang iyong buong pangalan.';
        break;
      case 'missing_email':
        title = 'Kulang na Impormasyon';
        message = 'Mangyaring ilagay ang iyong email address.';
        break;
      case 'missing_issue':
        title = 'Kulang na Impormasyon';
        message = 'Mangyaring ilarawan ang iyong isyu.';
        break;
      case 'invalid_email':
        title = 'Invalid Email';
        message = 'Mangyaring ilagay ang isang wastong email address.';
        break;
      case 'submission_error':
        title = 'Error';
        message =
            'Nangyari ang isang error sa pagsumite ng iyong ticket: $errorMessage';
        break;
      default:
        title = 'Unknown Error';
        message = 'Isang hindi kilalang error ang nangyari.';
    }

    // Call your existing custom alert dialog function
    showCustomAlertDialog(context, title, message);
  }
}
