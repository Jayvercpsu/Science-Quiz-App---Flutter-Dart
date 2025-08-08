import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../constants/app_colors.dart';

class StaggeredDotsLoader extends StatelessWidget {
  const StaggeredDotsLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.staggeredDotsWave(
      color: AppColors.kPrimary,
      size: 50,
    );
  }
}
