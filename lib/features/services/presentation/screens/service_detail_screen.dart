import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/providers/app_providers.dart';

class ServiceDetailScreen extends ConsumerWidget {
  final String serviceId;

  const ServiceDetailScreen({super.key, required this.serviceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(serviceRepositoryProvider);
    final service = repo.getServiceById(serviceId);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (service == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('الخدمة غير متوفرة')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(service.title),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            border: Border(
              top: BorderSide(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
            ),
          ),
          child: Row(
            children: [
              // Button 1: اطلب هذه الخدمة
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  onPressed: () =>
                      context.push('/service-request?serviceId=${service.id}'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('اطلب هذه الخدمة'),
                ),
              ),
              const SizedBox(width: 8),

              // Button 2: عرض سعر
              Expanded(
                flex: 2,
                child: OutlinedButton(
                  onPressed: () =>
                      context.push('/quotation-request?serviceId=${service.id}'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('عرض سعر'),
                ),
              ),
              const SizedBox(width: 8),

              // Button 3: معاينة
              Expanded(
                flex: 2,
                child: OutlinedButton(
                  onPressed: () =>
                      context.push('/inspection-request?serviceId=${service.id}'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('معاينة'),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder Image Container
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? AppColors.primaryNavyDark : AppColors.surfaceLight,
                borderRadius: AppRadius.roundedLg,
                border: Border.all(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.cleaning_services_rounded,
                    size: 48,
                    color: AppColors.accentGreen,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    service.title,
                    style: AppTypography.headlineMedium,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Category tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.accentGreen.withOpacity(0.15),
                borderRadius: AppRadius.roundedSm,
              ),
              child: Text(
                service.category,
                style: AppTypography.labelSmall.copyWith(color: AppColors.accentGreen),
              ),
            ),

            const SizedBox(height: 12),

            // Description
            Text('تفاصيل الخدمة', style: AppTypography.headlineMedium),
            const SizedBox(height: 6),
            Text(
              service.fullDescription,
              style: AppTypography.bodyLarge.copyWith(
                color: isDark ? Colors.white70 : AppColors.textSecondaryLight,
              ),
            ),

            const SizedBox(height: 20),

            // Included
            Text('الخدمات المشمولة', style: AppTypography.headlineMedium),
            const SizedBox(height: 8),
            ...service.included.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_rounded,
                          color: AppColors.accentGreen, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(item, style: AppTypography.bodyMedium),
                      ),
                    ],
                  ),
                )),

            const SizedBox(height: 20),

            // Suitable Locations
            Text('المنشآت والمواقع المستهدفة', style: AppTypography.headlineMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: service.suitableLocations
                  .map((loc) => Chip(
                        label: Text(loc),
                        backgroundColor:
                            isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                        side: BorderSide(
                          color: isDark ? AppColors.borderDark : AppColors.borderLight,
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
