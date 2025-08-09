import 'package:flutter/material.dart';
import '../app_colors.dart';  

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
    );
  }
}
