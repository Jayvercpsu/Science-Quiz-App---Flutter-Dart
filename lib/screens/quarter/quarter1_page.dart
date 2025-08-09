
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../constants/app_colors.dart';
import '../../components/quarter/quarter1/lesson_card.dart';
import '../../components/quarter/quarter1/quarter_progress_header.dart';
import '../../components/onboarding/loading_indicator.dart';

class Quarter1Page extends StatefulWidget {
  const Quarter1Page({super.key});

  @override
  State<Quarter1Page> createState() => _Quarter1PageState();
}

class _Quarter1PageState extends State<Quarter1Page>
    with SingleTickerProviderStateMixin {
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  
  final List<Map<String, dynamic>> lessons = [
    {
      'number': 1,
      'title': 'Lesson 1',
      'description': 'Introduction to Scientific Methods',
      'icon': Icons.science_rounded,
      'color': Colors.blue,
      'isCompleted': true,
      'isLocked': false,
      'progress': 1.0,
    },
    {
      'number': 2,
      'title': 'Lesson 2',
      'description': 'Measurement and Units',
      'icon': Icons.straighten_rounded,
      'color': Colors.green,
      'isCompleted': true,
      'isLocked': false,
      'progress': 1.0,
    },
    {
      'number': 3,
      'title': 'Lesson 3',
      'description': 'Matter and Its Properties',
      'icon': Icons.bubble_chart_rounded,
      'color': Colors.orange,
      'isCompleted': false,
      'isLocked': false,
      'progress': 0.6,
    },
    {
      'number': 4,
      'title': 'Lesson 4',
      'description': 'States of Matter',
      'icon': Icons.water_drop_rounded,
      'color': Colors.cyan,
      'isCompleted': false,
      'isLocked': false,
      'progress': 0.3,
    },
    {
      'number': 5,
      'title': 'Lesson 5',
      'description': 'Chemical vs Physical Changes',
      'icon': Icons.transform_rounded,
      'color': Colors.purple,
      'isCompleted': false,
      'isLocked': false,
      'progress': 0.0,
    },
    {
      'number': 6,
      'title': 'Lesson 6',
      'description': 'Elements and Compounds',
      'icon': Icons.category_rounded,
      'color': Colors.red,
      'isCompleted': false,
      'isLocked': true,
      'progress': 0.0,
    },
    {
      'number': 7,
      'title': 'Lesson 7',
      'description': 'Mixtures and Solutions',
      'icon': Icons.blender_rounded,
      'color': Colors.indigo,
      'isCompleted': false,
      'isLocked': true,
      'progress': 0.0,
    },
  ];

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabAnimation = CurvedAnimation(
      parent: _fabController,
      curve: Curves.easeInOut,
    );
    _fabController.forward();
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  void _navigateToLesson(BuildContext context, int lessonNumber) {
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const StaggeredDotsLoader(),
            const SizedBox(height: 16),
            Text(
              'Loading Lesson $lessonNumber...',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );

    
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); 
      Navigator.pushNamed(context, '/lesson$lessonNumber');
    });
  }

  void _showQuarterInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
              margin: const EdgeInsets.only(bottom: 20),
              alignment: Alignment.center,
            ),
            const Text(
              'Quarter 1 Overview',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.kPrimary,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'This quarter focuses on the fundamentals of scientific inquiry and matter. You\'ll learn about scientific methods, measurement, and the basic properties of matter.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Learning Objectives:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.kPrimary,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '• Master scientific investigation methods\n'
              '• Understand measurement and units\n'
              '• Identify properties of matter\n'
              '• Distinguish between physical and chemical changes\n'
              '• Classify matter into elements, compounds, and mixtures',
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int completedLessons = lessons
        .where((lesson) => lesson['isCompleted'])
        .length;
    double overallProgress = completedLessons / lessons.length;

    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        title: const Text(
          'Grade 7 - Quarter 1',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.kPrimary,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showQuarterInfo(context),
            icon: const Icon(Icons.info_outline_rounded),
            tooltip: 'Quarter Info',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.kPrimary.withOpacity(0.02),
              AppColors.kWhite,
              AppColors.kWhite,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                QuarterProgressHeader(
                  quarterTitle: 'Quarter 1',
                  totalLessons: lessons.length,
                  completedLessons: completedLessons,
                  overallProgress: overallProgress,
                ),

                
                FadeInDown(
                  duration: const Duration(milliseconds: 600),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.kPrimary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.menu_book_rounded,
                          color: AppColors.kPrimary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Lessons (1 to 7)',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.kPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: lessons.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final lesson = lessons[index];
                      return LessonCard(
                        lessonNumber: lesson['number'],
                        title: lesson['title'],
                        description: lesson['description'],
                        icon: lesson['icon'],
                        accentColor: lesson['color'],
                        onTap: () =>
                            _navigateToLesson(context, lesson['number']),
                        animationDelay: index * 100,
                        isCompleted: lesson['isCompleted'],
                        isLocked: lesson['isLocked'],
                        progress: lesson['progress'],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ScaleTransition(
        scale: _fabAnimation,
        child: FloatingActionButton.extended(
          onPressed: () => _showQuarterInfo(context),
          backgroundColor: AppColors.kPrimary,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.help_outline_rounded),
          label: const Text(
            'Help',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          elevation: 8,
        ),
      ),
    );
  }
}
