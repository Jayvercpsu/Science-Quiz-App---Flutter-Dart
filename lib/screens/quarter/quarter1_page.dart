import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../constants/app_colors.dart';
import '../../components/onboarding/primary_button.dart';
import '../../components/onboarding/loading_indicator.dart';

class Quarter1Page extends StatelessWidget {
  const Quarter1Page({super.key});

  void _navigateToLesson(BuildContext context, int lessonNumber) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: StaggeredDotsLoader()),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close loading
      Navigator.pushNamed(context, '/lesson$lessonNumber'); // Navigate
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        title: const Text('Grade 7 - Quarter 1'),
        backgroundColor: AppColors.kPrimary,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                child: const Text(
                  'Lessons (1 to 7)',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: ListView.separated(
                  itemCount: 7,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final lesson = index + 1;
                    return FadeInUp(
                      duration: Duration(milliseconds: 400 + (index * 100)),
                      child: PrimaryButton(
                        text: 'Lesson $lesson',
                        onTap: () => _navigateToLesson(context, lesson),
                        height: 60,
                        fontSize: 16,
                        borderRadius: 14,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
