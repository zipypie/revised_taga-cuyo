import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashAnimation extends StatefulWidget {
  final String mainAnimationPath; // Path for the primary animation
  final double mainAnimationSize; // Size for the primary animation
  final bool repeatMainAnimation; // Whether to repeat the primary animation

  const SplashAnimation({
    super.key,
    required this.mainAnimationPath,
    this.mainAnimationSize = 250,
    this.repeatMainAnimation = true,
  });

  /// Factory constructor for the `book` animation
  factory SplashAnimation.book({double size = 250}) {
    return SplashAnimation(
      mainAnimationPath: AnimationStrings.book,
      mainAnimationSize: size,
    );
  }

  /// Factory constructor for the `loading` animation
  factory SplashAnimation.loading({double size = 300}) {
    return SplashAnimation(
      mainAnimationPath: AnimationStrings.loading,
      mainAnimationSize: size,
    );
  }

  factory SplashAnimation.confetti({double size = double.infinity}) {
    return SplashAnimation(
      mainAnimationPath: AnimationStrings.loading,
      mainAnimationSize: size,
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
        // Darkened background overlay
        Container(
          color: Colors.black.withOpacity(0.5), // Adjust opacity for darkness
        ),
        // Centered loading animation
        Center(
          child: Lottie.asset(
            widget.mainAnimationPath,
            width: widget.mainAnimationSize,
            height: widget.mainAnimationSize,
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
