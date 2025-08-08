import 'package:flutter/material.dart';
import '../utils/sound_player.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:animate_do/animate_do.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../components/onboarding/loading_indicator.dart';
import '../components/onboarding/primary_button.dart';
import '../components/onboarding/custom_text_button.dart';
import '../components/onboarding/wavecard.dart';
import '../components/onboarding/custom_icon_button.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    SoundPlayer();  
    _pageController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      extendBodyBehindAppBar: true,
      appBar: _currentIndex > 0
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leadingWidth: 70,
              leading: Padding(
                padding: const EdgeInsets.all(7),
                child: CustomIconButton(
                  onTap: () async {
                    await SoundPlayer.playTap();
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                  icon: '',
                ),
              ),
            )
          : null,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              const WaveCard(),
              Positioned(
                top: 100,
                child: Image.asset(onboardingList[_currentIndex].image),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingList.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return OnboardingCard(onboarding: onboardingList[index]);
              },
            ),
          ),
          CustomIndicator(
            controller: _pageController,
            dotsLength: onboardingList.length,
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: PrimaryButton(
              onTap: () async {
                await SoundPlayer.playTap();
                if (_currentIndex == (onboardingList.length - 1)) {
                  // Show loading first, then navigate
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const Center(child: StaggeredDotsLoader()),
                  );

                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pop(context); // Close loading
                    Navigator.pushReplacementNamed(context, '/home');
                  });
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                }
              },
              text: _currentIndex == (onboardingList.length - 1)
                  ? 'Get Started'
                  : 'Continue',
            ),
          ),

          // Show Skip only if not on the last page
          if (_currentIndex != (onboardingList.length - 1))
            CustomTextButton(
              onPressed: () async {
                await SoundPlayer.playTap();
                Navigator.pushReplacementNamed(context, '/home');
              },
              text: 'Skip',
            ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class CustomIndicator extends StatelessWidget {
  final PageController controller;
  final int dotsLength;
  final double? height;
  final double? width;
  const CustomIndicator({
    required this.controller,
    required this.dotsLength,
    this.height,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: dotsLength,
      onDotClicked: (index) {},
      effect: SlideEffect(
        dotColor: AppColors.kSecondary.withOpacity(0.3),
        activeDotColor: AppColors.kSecondary,
        dotHeight: height ?? 8,
        dotWidth: width ?? 8,
      ),
    );
  }
}

class OnboardingCard extends StatelessWidget {
  final Onboarding onboarding;
  const OnboardingCard({required this.onboarding, super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.3,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: Text(
                onboarding.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              child: Text(
                onboarding.description,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Onboarding {
  String title;
  String description;
  String image;
  Onboarding({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<Onboarding> onboardingList = [
  Onboarding(
    title: '''Welcome to
ScienceQuiz!''',
    image: AppAssets.kOnboarding1,
    description: '''Learn and have fun with interactive
Science lessons made for Grade 7
students like you!''',
  ),
  Onboarding(
    title: '''Explore lessons
by Quarter''',
    image: AppAssets.kOnboarding2,
    description: '''Choose your quarter, read short and
exciting lessons, and understand
science step by step.''',
  ),
  Onboarding(
    title: '''Answer Quizzes
and Analyze Results!''',
    image: AppAssets.kOnboarding3,
    description: '''Test your knowledge with fun quizzes
at the end of each lesson. Show
how much you've learned!''',
  ),
];
