import 'package:flutter/material.dart';
import '../../utils/sound_player.dart';
import '../../constants/app_colors.dart';
import '../../components/onboarding/wavecard.dart';
import '../../components/home/welcome_section.dart';
import '../../components/home/quarters_list.dart';
import '../../components/onboarding/loading_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _navigateWithTap(
    BuildContext context,
    String route,
    String title,
  ) async {
    await SoundPlayer.playTap();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const StaggeredDotsLoader(),
              const SizedBox(height: 16),
              Flexible(
                child: Text(
                  'Loading $title...',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 2));

    Navigator.of(context, rootNavigator: true).pop();
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: Stack(
        children: [
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

                  const WelcomeSection(),

                  const SizedBox(height: 50),

                  Expanded(
                    child: QuartersList(
                      onQuarterSelected: (route, title) =>
                          _navigateWithTap(context, route, title),
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
