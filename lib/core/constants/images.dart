import 'package:flutter/widgets.dart';

class LocalImages {
  // Example: String paths for assets
  static const String cashew1 = 'assets/images/cashew_megaphone.png';
  static const String event1 = 'assets/images/event1.jpg';
  static const String event2 = 'assets/images/event2.jpg';
  static const String destination2 = 'assets/images/destination2.jpg';
  static const String destination1 = 'assets/images/destination1.jpg';
  static const String getStarted1 = 'assets/images/get_started_1.png';
  static const String getStarted2 = 'assets/images/get_started_2.png';
  static const String getStarted3 = 'assets/images/get_started_3.png';

  // Widget factories for direct usage
  static Widget cashew1Image(
          {double? width, double? height, BoxFit fit = BoxFit.cover}) =>
      ImageFactory.asset(src: cashew1, width: width, height: height, fit: fit);

  static Widget event1Image(
          {double? width, double? height, BoxFit fit = BoxFit.cover}) =>
      ImageFactory.asset(src: event1, width: width, height: height, fit: fit);

  // Repeat for other images...
}

class LogoImage {
  static const String logoPath = 'assets/images/taga_cuyo.png';

  // Direct widget creation
  static Widget logo(
          {double? width, double? height, BoxFit fit = BoxFit.cover}) =>
      ImageFactory.asset(src: logoPath, width: width, height: height, fit: fit);
}

class ImageFactory {
  // Loads an image asset as a widget with optional parameters
  static Widget asset({
    required String src,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image.asset(
      src,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
