import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/providers/app_providers.dart';

class ProjectsScreen extends ConsumerWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(projectsListProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('مشاريعنا وسابقة الأعمال'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Stat Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryNavy,
              borderRadius: AppRadius.roundedLg,
              boxShadow: AppShadows.cardDark,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppConstants.completedProjectsCount,
                  style: AppTypography.headlineLarge.copyWith(
                    color: AppColors.accentGreen,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'أعمال وعقود صيانة وتشغيل كبرى تم تنفيذها في مختلف مناطق المملكة بأعلى معايير الجودة العالمية.',
                  style: AppTypography.bodyMedium.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          ...projects.map((proj) {
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          proj.imageAsset,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.apartment_rounded,
                                  size: 48,
                                  color: AppColors.accentGreen,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  proj.serviceType,
                                  style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Subtle gradient overlay at the bottom of the card image
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          height: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.4),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(proj.title, style: AppTypography.headlineMedium),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 14, color: AppColors.accentGreen),
                            const SizedBox(width: 4),
                            Text(proj.location, style: AppTypography.caption),
                            const Spacer(),
                            Text('إنجاز: ${proj.completionDate}', style: AppTypography.caption),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(proj.shortDescription, style: AppTypography.bodyMedium),
                        const SizedBox(height: 8),
                        Text(
                          'نطاق المشروع: ${proj.scope}',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.accentGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: () => context.push('/quotation-request'),
                          child: const Text('طلب عرض سعر لمشروع مماثل'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
