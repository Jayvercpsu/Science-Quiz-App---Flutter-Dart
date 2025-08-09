// components/home/quarters_list.dart
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart'; 
import '../../constants/app_colors.dart';
import 'quarter_button.dart'; 

class QuartersList extends StatefulWidget {
  final Function(String route, String title) onQuarterSelected;

  const QuartersList({
    super.key,
    required this.onQuarterSelected,
  });

  @override
  State<QuartersList> createState() => _QuartersListState();
}

class _QuartersListState extends State<QuartersList> {
  
  final List<Map<String, dynamic>> quarters = [
    {
      'title': 'Grade 7 Quarter 1',
      'icon': Icons.looks_one_rounded,
      'color': Colors.blue,
      'route': '/quarter1',
    },
    {
      'title': 'Grade 7 Quarter 2',
      'icon': Icons.looks_two_rounded,
      'color': Colors.green,
      'route': '/quarter2',
    },
    {
      'title': 'Grade 7 Quarter 3',
      'icon': Icons.looks_3_rounded,
      'color': Colors.orange,
      'route': '/quarter3',
    },
    {
      'title': 'Grade 7 Quarter 4',
      'icon': Icons.looks_4_rounded,
      'color': Colors.purple,
      'route': '/quarter4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 700),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header section
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.timeline_rounded,
                    color: AppColors.kPrimary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Select Your Quarter',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.kPrimary,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),

            // Quarters list
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: quarters.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final quarter = quarters[index];
                  return QuarterButton(
                    text: quarter['title'],
                    icon: quarter['icon'],
                    accentColor: quarter['color'],
                    onTap: () => widget.onQuarterSelected(
                      quarter['route'],
                      quarter['title'],
                    ),
                    index: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
