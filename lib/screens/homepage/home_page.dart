import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../constants/app_colors.dart';
import '../../components/onboarding/loading_indicator.dart';
import '../../components/onboarding/primary_button.dart';
import '../../components/onboarding/wavecard.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _navigateWithLoading(BuildContext context, String route) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: StaggeredDotsLoader()),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      Navigator.pushNamed(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: Stack(
        children: [
          const WaveCard(height: 300),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  FadeInDown(
                    duration: const Duration(milliseconds: 500),
                    child: const Text(
                      'Welcome!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kPrimary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  FadeInDown(
                    duration: const Duration(milliseconds: 600),
                    child: const Text(
                      'Tap to start learning Grade 7 Quarters',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),

                  Expanded(
                    child: FadeInUp(
                      duration: const Duration(milliseconds: 700),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PrimaryButton(
                              text: 'Grade 7 - Quarter 1',
                              onTap: () =>
                                  _navigateWithLoading(context, '/quarter1'),
                              height: 60,
                              fontSize: 18,
                              borderRadius: 12,
                            ),
                            const SizedBox(height: 16),
                            PrimaryButton(
                              text: 'Grade 7 - Quarter 2',
                              onTap: () =>
                                  _navigateWithLoading(context, '/quarter2'),
                              height: 60,
                              fontSize: 18,
                              borderRadius: 12,
                            ),
                            const SizedBox(height: 16),
                            PrimaryButton(
                              text: 'Grade 7 - Quarter 3',
                              onTap: () =>
                                  _navigateWithLoading(context, '/quarter3'),
                              height: 60,
                              fontSize: 18,
                              borderRadius: 12,
                            ),
                            const SizedBox(height: 16),
                            PrimaryButton(
                              text: 'Grade 7 - Quarter 4',
                              onTap: () =>
                                  _navigateWithLoading(context, '/quarter4'),
                              height: 60,
                              fontSize: 18,
                              borderRadius: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
