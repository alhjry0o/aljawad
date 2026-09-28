import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/providers/app_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeModeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات والمزيد'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Section 1: الشركة
          Text('الشركة', style: AppTypography.labelLarge.copyWith(color: AppColors.accentGreen)),
          const SizedBox(height: 8),
          ListTile(
            shape: RoundedRectangleBorder(borderRadius: AppRadius.roundedMd),
            tileColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            leading: const Icon(Icons.info_outline, color: AppColors.accentGreen),
            title: const Text('عن شركة الجواد'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () => context.push('/about'),
          ),
          const SizedBox(height: 6),
          ListTile(
            shape: RoundedRectangleBorder(borderRadius: AppRadius.roundedMd),
            tileColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            leading: const Icon(Icons.phone_outlined, color: AppColors.accentGreen),
            title: const Text('تواصل معنا'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () => context.push('/contact'),
          ),

          const SizedBox(height: 20),

          // Section 2: المظهر واللغة
          Text('المظهر والتفضيلات', style: AppTypography.labelLarge.copyWith(color: AppColors.accentGreen)),
          const SizedBox(height: 8),
          ListTile(
            shape: RoundedRectangleBorder(borderRadius: AppRadius.roundedMd),
            tileColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            leading: const Icon(Icons.palette_outlined, color: AppColors.accentGreen),
            title: const Text('مظهر التطبيق'),
            subtitle: Text(
              currentThemeMode == ThemeMode.light
                  ? 'فاتح'
                  : currentThemeMode == ThemeMode.dark
                      ? 'داكن'
                      : 'حسب نظام الجهاز',
            ),
            trailing: DropdownButton<ThemeMode>(
              value: currentThemeMode,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(value: ThemeMode.system, child: Text('النظام')),
                DropdownMenuItem(value: ThemeMode.light, child: Text('فاتح')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('داكن')),
              ],
              onChanged: (mode) {
                if (mode != null) {
                  ref.read(themeModeProvider.notifier).setThemeMode(mode);
                }
              },
            ),
          ),
          const SizedBox(height: 6),
          ListTile(
            shape: RoundedRectangleBorder(borderRadius: AppRadius.roundedMd),
            tileColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            leading: const Icon(Icons.language_rounded, color: AppColors.accentGreen),
            title: const Text('لغة التطبيق'),
            subtitle: const Text('العربية (جاهز لإضافة English لاحقاً)'),
          ),

          const SizedBox(height: 20),

          // Section 3: المطور وحقوق التطوير
          Text('المطور وحقوق الملكية', style: AppTypography.labelLarge.copyWith(color: AppColors.accentGreen)),
          const SizedBox(height: 8),
          ListTile(
            shape: RoundedRectangleBorder(borderRadius: AppRadius.roundedMd),
            tileColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            leading: const Icon(Icons.code_rounded, color: AppColors.accentGreen),
            title: const Text('معلومات المطور (Developer Credits)'),
            subtitle: const Text('${AppConstants.developerNameAr} (${AppConstants.developerNameEn})'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () => context.push('/developer'),
          ),

          const SizedBox(height: 20),

          // Section 4: معلومات الإصدار
          Center(
            child: Column(
              children: [
                Text(
                  '${AppConstants.appDisplayName} v1.0.0 (Release Build)',
                  style: AppTypography.caption,
                ),
                Text(
                  AppConstants.developerCopyright,
                  style: AppTypography.caption.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
