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
          Text(
            'الشركة',
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.accentGreen,
            ),
          ),
          const SizedBox(height: 8),

          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.roundedMd,
            ),
            tileColor:
                isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            leading: const Icon(
              Icons.info_outline,
              color: AppColors.accentGreen,
            ),
            title: const Text('عن شركة الجواد'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () => context.push('/about'),
          ),

          const SizedBox(height: 6),

          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.roundedMd,
            ),
            tileColor:
                isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            leading: const Icon(
              Icons.phone_outlined,
              color: AppColors.accentGreen,
            ),
            title: const Text('تواصل معنا'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () => context.push('/contact'),
          ),

          const SizedBox(height: 20),

          // Section 2: المظهر واللغة
          Text(
            'المظهر والتفضيلات',
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.accentGreen,
            ),
          ),
          const SizedBox(height: 8),

          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.roundedMd,
            ),
            tileColor:
                isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            leading: const Icon(
              Icons.palette_outlined,
              color: AppColors.accentGreen,
            ),
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
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('النظام'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('فاتح'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('داكن'),
                ),
              ],
              onChanged: (mode) {
                if (mode != null) {
                  ref
                      .read(themeModeProvider.notifier)
                      .setThemeMode(mode);
                }
              },
            ),
          ),

          const SizedBox(height: 6),

          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.roundedMd,
            ),
            tileColor:
                isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            leading: const Icon(
              Icons.language_rounded,
              color: AppColors.accentGreen,
            ),
            title: const Text('لغة التطبيق'),
            subtitle: const Text(
              'العربية (جاهز لإضافة English لاحقاً)',
            ),
          ),

          const SizedBox(height: 20),

          // Section 3: معلومات التطبيق والخصوصية
          Text(
            'معلومات التطبيق',
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.accentGreen,
            ),
          ),
          const SizedBox(height: 8),

          // Privacy Policy
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.roundedMd,
            ),
            tileColor:
                isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            leading: const Icon(
              Icons.privacy_tip_outlined,
              color: AppColors.accentGreen,
            ),
            title: const Text('سياسة الخصوصية'),
            subtitle: const Text(
              'معلومات حول بيانات العملاء وطلبات الخدمات',
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('سياسة الخصوصية'),
                  content: const SingleChildScrollView(
                    child: Text(
                      'سياسة الخصوصية\n\n'
                      'يحترم تطبيق الجواد خصوصية عملائه ويسعى إلى حماية '
                      'البيانات والمعلومات التي يتم تقديمها عند استخدام خدمات التطبيق.\n\n'
                      'البيانات التي قد يتم تقديمها\n'
                      'عند طلب خدمة أو عرض سعر أو معاينة ميدانية، قد يطلب التطبيق '
                      'من العميل تقديم بعض البيانات اللازمة لمعالجة الطلب، مثل:\n\n'
                      '• الاسم.\n'
                      '• رقم الهاتف وبيانات التواصل.\n'
                      '• عنوان العميل أو موقع تقديم الخدمة.\n'
                      '• نوع الخدمة المطلوبة.\n'
                      '• تفاصيل الطلب والملاحظات المتعلقة بالخدمة.\n'
                      '• الموعد أو الوقت المفضل لتنفيذ الخدمة.\n'
                      '• أي معلومات أخرى يختار العميل تقديمها والمتعلقة بطلب الخدمة.\n\n'
                      'استخدام البيانات\n'
                      'تستخدم هذه البيانات لمعالجة طلب العميل والتواصل معه، '
                      'وفهم احتياجاته، وتحديد نطاق الخدمة، وتقديم عروض الأسعار، '
                      'وتنسيق المعاينات والخدمات المطلوبة، وتحسين جودة الخدمات المقدمة.\n\n'
                      'حماية البيانات\n'
                      'تسعى شركة الجواد إلى التعامل مع بيانات العملاء بسرية واتخاذ '
                      'الإجراءات المناسبة لحمايتها من الوصول أو الاستخدام غير المصرح به.\n\n'
                      'مشاركة البيانات\n'
                      'لا يتم بيع بيانات العملاء أو استخدامها لأغراض تجارية غير مرتبطة '
                      'بالخدمة المطلوبة. وقد يتم مشاركة البيانات بالقدر اللازم مع '
                      'الأطراف أو الفرق المعنية بتنفيذ الخدمة، أو عندما يكون ذلك '
                      'مطلوباً بموجب الأنظمة والقوانين المعمول بها.\n\n'
                      'النسخة التجريبية\n'
                      'هذا التطبيق في نسخته الحالية هو نسخة تجريبية أولية مقدمة '
                      'للاستعراض والتقييم. وقد يتم تعديل آلية جمع البيانات ومعالجتها '
                      'وتحديث سياسة الخصوصية عند اعتماد وإطلاق النسخة الرسمية من التطبيق.\n\n'
                      'باستخدام خدمات التطبيق وتقديم البيانات، يقر العميل بأنه يقدم '
                      'المعلومات اللازمة لمعالجة طلبه وفق الغرض الموضح أعلاه.',
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('إغلاق'),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 6),

          // App Information
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.roundedMd,
            ),
            tileColor:
                isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            leading: const Icon(
              Icons.info_outline_rounded,
              color: AppColors.accentGreen,
            ),
            title: const Text('معلومات التطبيق'),
            subtitle: const Text(
              'الإصدار والمنصة وحالة النسخة',
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('معلومات التطبيق'),
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('اسم التطبيق: الجواد'),
                      SizedBox(height: 8),
                      Text('الاسم بالإنجليزية: Aljawad'),
                      SizedBox(height: 8),
                      Text('الشركة: AL-Gawad Group'),
                      SizedBox(height: 8),
                      Text('الإصدار: 1.0.0'),
                      SizedBox(height: 8),
                      Text('المنصة: Android'),
                      SizedBox(height: 8),
                      Text('نوع النسخة: نسخة تجريبية'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('إغلاق'),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 28),

          // Company Ownership & Trial Version Notice
          Center(
            child: Column(
              children: [
                Text(
                  '© 2026 شركة الجواد الدولية والعربية',
                  style: AppTypography.caption.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  'جميع الحقوق محفوظة',
                  style: AppTypography.caption.copyWith(
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'فريق الإعداد والتطوير: عبدالله الحجري (Abdullah AL-Hjry)',
                  style: AppTypography.caption.copyWith(
                    fontSize: 9,
                    color: isDark ? Colors.white38 : Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'هذا التطبيق نسخة تجريبية أولية مقدمة للاستعراض والتقييم، '
                  'وسيتم إصدار النسخة الرسمية بعد اعتماد الشركة.',
                  style: AppTypography.caption.copyWith(
                    fontSize: 9,
                    color: isDark ? Colors.white30 : Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
