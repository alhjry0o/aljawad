import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final sectors = [
      'النظافة الشاملة والعميقة للمنازل والمنشآت',
      'تنظيف الواجهات المرتفعة الزجاجية والحجرية والكلادينج',
      'تنظيف المواقف والمنشآت الصناعية وجلي وتلميع الأرضيات',
      'تنظيف وصيانة المسابح وموازنة الكيماويات',
      'مكافحة الآفات والحشرات والوقاية والتبخير',
      'العزل المائي والحراري وعزل الخزانات بالإيبوكسي',
      'أعمال السباكة والكهرباء وصيانة التكييف المركزي والمخفي',
      'توفير الكوادر والعمالة المتخصصة والمساندة',
      'إدارة وتشغيل وصيانة المرافق والمجمعات',
      'تأجير المعدات والرافعات الهيدروليكية والمولدات',
      'الإنشاءات والمقاولات العامة والتشطيبات المعمارية',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('عن شركة الجواد'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primaryNavy,
                borderRadius: AppRadius.roundedLg,
                boxShadow: AppShadows.cardDark,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceNavyLight.withOpacity(0.5),
                          borderRadius: AppRadius.roundedMd,
                          border: Border.all(
                            color: AppColors.accentGreen.withOpacity(0.4),
                          ),
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Image.asset(
                          AppAssets.logo,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => const Center(
                            child: Text(
                              'جـ',
                              style: TextStyle(
                                color: AppColors.accentGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppConstants.companyName,
                              style: AppTypography.displayMedium.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              AppConstants.mainHeadline,
                              style: AppTypography.labelLarge.copyWith(
                                color: AppColors.accentGreen,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'رؤية الشركة',
              style: AppTypography.headlineLarge,
            ),
            const SizedBox(height: 6),
            Text(
              'تعد شركة الجواد الدولية العربية إحدى الشركات الرائدة المتخصصة في تقديم منظومة حلول متكاملة في مجالات التشغيل والصيانة والنظافة وإدارة المرافق والمقاولات في المملكة العربية السعودية، مع الالتزام بأعلى معايير الجودة والسلامة المهنية.',
              style: AppTypography.bodyLarge.copyWith(
                color: isDark ? Colors.white70 : AppColors.textSecondaryLight,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'قطاعات ومجالات عمل الشركة',
              style: AppTypography.headlineLarge,
            ),
            const SizedBox(height: 8),
            ...sectors.map((sec) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle_outline, color: AppColors.accentGreen, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(sec, style: AppTypography.bodyMedium),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
