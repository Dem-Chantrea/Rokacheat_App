import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mobile_assignment/constants/app_image.dart';
import 'package:mobile_assignment/routes/app_route.dart';

class OnBorderingScreen extends StatelessWidget {
  const OnBorderingScreen({super.key});

  void _onIntroEnd(BuildContext context) {
    // Navigate to Login or Home
    Navigator.pushReplacementNamed(context, AppRoute.signin);
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      infiniteAutoScroll: true,
      autoScrollDuration: 3000,
      controlsMargin: EdgeInsets.only(bottom: 10),
      pages: [
        PageViewModel(
          titleWidget: Text(
            "Plant Secrets",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          bodyWidget: Text(
            "Discover the hidden beauty of plants and learn how to care for them with ease.",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          image: _buildImage(AppImage.onboarding1),
        ),
        PageViewModel(
          titleWidget: Text(
            "Plant care",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          bodyWidget: Text(
            "Easy tips to water, grow, and protect your plants with confidence.",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          image: _buildImage(AppImage.onboarding2),
        ),
        PageViewModel(
          titleWidget: Text(
            "Plant Varieties",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          bodyWidget: Text(
            "Explore different types of plants and discover which ones suit your space.",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          image: _buildImage(AppImage.onboarding3),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      skip: Text(
        "Skip".toUpperCase(),
        style: TextStyle(
          color: Color(0xff5A9B73),
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      next: Text(
        "Next".toUpperCase(),
        style: TextStyle(
          color: Color(0xff5A9B73),
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      done: Text(
        "Done".toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xff5A9B73),
          fontSize: 16,
        ),
      ),
      dotsDecorator: DotsDecorator(
        size: Size(10, 10),
        activeColor: Color(0xff5A9B73),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String imagePath) {
    return Image.asset(
      imagePath,
      width: 300,
      height: 300,
      fit: BoxFit.cover,
    );
  }
}
