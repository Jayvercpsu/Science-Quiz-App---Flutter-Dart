import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:animate_do/animate_do.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
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
                  onTap: () {
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
              onTap: () {
                if (_currentIndex == (onboardingList.length - 1)) {
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
          CustomTextButton(
            onPressed: () {
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

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  final double? fontSize;
  const CustomTextButton({
    required this.onPressed,
    required this.text,
    this.fontSize,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: color ?? const Color(0xFF329494),
          fontSize: fontSize ?? 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final Color? color;
  const PrimaryButton({
    required this.onTap,
    required this.text,
    this.height,
    this.width,
    this.borderRadius,
    this.fontSize,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: _animationDuration)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Container(
          height: widget.height ?? 60,
          alignment: Alignment.center,
          width: widget.width ?? double.maxFinite,
          decoration: BoxDecoration(
            color:
                widget.color ??
                (isDarkMode(context) ? Colors.black : const Color(0xFF329494)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF329494).withOpacity(0.2),
                blurRadius: 7,
                offset: const Offset(0, 5),
              ),
            ],
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: widget.color == null ? Colors.white : Colors.black,
              fontSize: widget.fontSize ?? 20,
            ),
          ),
        ),
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
    return Column(
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
and Earn Stars!''',
    image: AppAssets.kOnboarding3,
    description: '''Test your knowledge with fun quizzes
at the end of each lesson. Show
how much you've learned!''',
  ),
];

class WaveCard extends StatelessWidget {
  final double? height;
  final Color? color;
  const WaveCard({super.key, this.height, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 350,
      width: double.infinity,
      color: color ?? AppColors.kPrimary.withOpacity(0.15),
      child: CustomPaint(painter: WavePainter(color: AppColors.kWhite)),
    );
  }
}

class WavePainter extends CustomPainter {
  final Color color;

  WavePainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.75);
    path.quadraticBezierTo(
      size.width * 0.85,
      size.height * 0.625,
      size.width * 0.5,
      size.height * 0.75,
    );
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.875,
      0,
      size.height * 0.75,
    );
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CustomIconButton extends StatefulWidget {
  final VoidCallback onTap;
  final double? size;
  final Color? color;
  final String icon;
  final Color? iconColor;
  const CustomIconButton({
    required this.onTap,
    required this.icon,
    this.size,
    this.color,
    this.iconColor,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: _animationDuration)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Container(
          height: widget.size ?? 40,
          alignment: Alignment.center,
          width: widget.size ?? 40,
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            color: AppColors.kWhite,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
