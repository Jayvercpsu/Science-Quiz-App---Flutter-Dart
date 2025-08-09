import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../../constants/app_colors.dart';

class QuarterProgressHeader extends StatelessWidget {
  final String quarterTitle;
  final int totalLessons;
  final int completedLessons;
  final double overallProgress;

  const QuarterProgressHeader({
    super.key,
    required this.quarterTitle,
    required this.totalLessons,
    required this.completedLessons,
    required this.overallProgress,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 500),
      child: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.kPrimary.withOpacity(0.1),
              AppColors.kPrimary.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.kPrimary.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.school_rounded,
                    color: AppColors.kPrimary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quarterTitle,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.kPrimary,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Science Learning Journey',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.kPrimary.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$completedLessons/$totalLessons',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Icon(
                  Icons.timeline_rounded,
                  color: AppColors.kPrimary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Overall Progress',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.kPrimary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Container(
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.kPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: overallProgress,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.kPrimary,
                        AppColors.kPrimary.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${(overallProgress * 100).toInt()}% Complete',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.kPrimary.withOpacity(0.8),
                  ),
                ),
                Text(
                  '${totalLessons - completedLessons} lessons remaining',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.kPrimary.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
