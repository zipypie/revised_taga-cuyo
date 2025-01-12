import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashAnimation extends StatefulWidget {
  final String mainAnimationPath; // Path for the primary animation
  final double mainAnimationWidth; // Width for the primary animation
  final double mainAnimationHeight; // Height for the primary animation
  final bool repeatMainAnimation; // Whether to repeat the primary animation

  const SplashAnimation({
    super.key,
    required this.mainAnimationPath,
    this.mainAnimationWidth = 250,
    this.mainAnimationHeight = 250,
    this.repeatMainAnimation = true,
  });

  /// Factory constructor for the `book` animation
  factory SplashAnimation.book({double width = 250, double height = 250}) {
    return SplashAnimation(
      mainAnimationPath: AnimationStrings.book,
      mainAnimationWidth: width,
      mainAnimationHeight: height,
    );
  }

  /// Factory constructor for the `loading` animation
  factory SplashAnimation.loading({double width = 300, double height = 300}) {
    return SplashAnimation(
      mainAnimationPath: AnimationStrings.loading,
      mainAnimationWidth: width,
      mainAnimationHeight: height,
    );
  }

  factory SplashAnimation.confetti({double width = 250, double height = 250}) {
    return SplashAnimation(
      mainAnimationPath: AnimationStrings.confetti,
      mainAnimationWidth: width,
      mainAnimationHeight: height,
      repeatMainAnimation: false,
    );
  }

  @override
  SplashAnimationState createState() => SplashAnimationState();
}

class SplashAnimationState extends State<SplashAnimation>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Lottie.asset(
            widget.mainAnimationPath,
            width: widget.mainAnimationWidth,
            height: widget.mainAnimationHeight,
          ),
        ),
      ],
    );
  }
}

class AnimationStrings {
  static const String book = 'assets/animation/booksplash.json';
  static const String loading = 'assets/animation/loadingsplash.json';
  static const String confetti = 'assets/animation/confetti.json';
}
