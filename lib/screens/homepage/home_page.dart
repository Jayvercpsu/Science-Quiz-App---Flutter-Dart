// pages/home/home_page.dart
import 'package:flutter/material.dart';
import '../../utils/sound_player.dart'; 
import '../../constants/app_colors.dart';
import '../../components/onboarding/wavecard.dart';
import '../../components/home/welcome_section.dart';
import '../../components/home/quarters_list.dart';
import '../../components/onboarding/loading_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _navigateWithTap(BuildContext context, String route) async {
    await SoundPlayer.playTap(); // 🔊 Play sound first

    // Show loading overlay
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: StaggeredDotsLoader()),
    );

    // Simulate short loading delay
    await Future.delayed(const Duration(seconds: 2));

    // Close loader and navigate
    Navigator.of(context, rootNavigator: true).pop();
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: Stack(
        children: [
          // Enhanced background with gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.kPrimary.withOpacity(0.05),
                  AppColors.kWhite,
                  AppColors.kPrimary.withOpacity(0.02),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

          const WaveCard(height: 320),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),

                  // Welcome Section Component
                  const WelcomeSection(),

                  const SizedBox(height: 50),

                  // Quarters List Component with Scroll Indicator
                  Expanded(
                    child: QuartersList(
                      onQuarterSelected: (route) =>
                          _navigateWithTap(context, route),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
