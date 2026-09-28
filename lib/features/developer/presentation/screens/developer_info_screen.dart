import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';

class DeveloperInfoScreen extends StatelessWidget {
  const DeveloperInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('معلومات المطور'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.accentGreen.withOpacity(0.15),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.accentGreen, width: 2),
                ),
                child: const Icon(
                  Icons.terminal_rounded,
                  color: AppColors.accentGreen,
                  size: 36,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'تطوير وبرمجة التطبيق',
                style: AppTypography.caption.copyWith(
                  color: AppColors.accentGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                AppConstants.developerNameAr,
                style: AppTypography.displayMedium,
              ),
              Text(
                AppConstants.developerNameEn,
                style: AppTypography.labelLarge.copyWith(
                  color: isDark ? Colors.white70 : AppColors.textSecondaryLight,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppConstants.developerRole,
                style: AppTypography.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Contact Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : AppColors.cardLight,
                  borderRadius: AppRadius.roundedLg,
                  border: Border.all(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.phone_rounded, color: AppColors.accentGreen),
                      title: const Text('رقم الهاتف والتواصل المباشر'),
                      subtitle: Text(
                        AppConstants.developerContact,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace'),
                      ),
                      onTap: () => launchUrl(Uri.parse('tel:${AppConstants.developerContact}')),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.chat_rounded, color: AppColors.accentGreen),
                      title: const Text('المراسلة عبر واتساب'),
                      subtitle: const Text('بدء محادثة فورية'),
                      onTap: () => launchUrl(Uri.parse('https://wa.me/967779966185')),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Text(
                AppConstants.developerCredits,
                style: AppTypography.caption.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                AppConstants.developerCopyright,
                style: AppTypography.caption.copyWith(fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
