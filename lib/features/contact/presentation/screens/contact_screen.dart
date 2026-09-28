import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _msgController = TextEditingController();
  bool _submitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _msgController.dispose();
    super.dispose();
  }

  void _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('تواصل معنا'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Head Office Info
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded, color: AppColors.accentGreen),
                      const SizedBox(width: 8),
                      Text(AppConstants.companyName, style: AppTypography.headlineMedium),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(AppConstants.companyAddress, style: AppTypography.bodyMedium),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () => _launch('https://maps.google.com/?q=Riyadh+Olaya+Riyadh+Gallery'),
                    icon: const Icon(Icons.map_rounded),
                    label: const Text('فتح الموقع على خرائط جوجل'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Text('قنوات التواصل المعتمدة', style: AppTypography.headlineMedium),
            const SizedBox(height: 8),

            // Unified Phone
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: AppRadius.roundedMd),
              tileColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              leading: const Icon(Icons.phone_in_talk, color: AppColors.accentGreen),
              title: const Text('الرقم الموحد المعتمد'),
              subtitle: const Text(AppConstants.phoneUnified),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () => _launch('tel:${AppConstants.phoneUnified}'),
            ),
            const SizedBox(height: 8),

            // WhatsApp
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: AppRadius.roundedMd),
              tileColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              leading: const Icon(Icons.chat_bubble_outline, color: AppColors.accentGreen),
              title: const Text('واتساب خدمة العملاء'),
              subtitle: const Text(AppConstants.whatsappNumber),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () => _launch('https://wa.me/966${AppConstants.whatsappNumber.replaceFirst(RegExp(r"^0+"), "")}'),
            ),
            const SizedBox(height: 8),

            // Mobiles
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: AppRadius.roundedMd),
              tileColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              leading: const Icon(Icons.phone_android, color: AppColors.accentGreen),
              title: const Text('الجوال المباشر (1)'),
              subtitle: const Text(AppConstants.mobile1),
              onTap: () => _launch('tel:${AppConstants.mobile1}'),
            ),
            const SizedBox(height: 8),
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: AppRadius.roundedMd),
              tileColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              leading: const Icon(Icons.phone_android, color: AppColors.accentGreen),
              title: const Text('الجوال المباشر (2)'),
              subtitle: const Text(AppConstants.mobile2),
              onTap: () => _launch('tel:${AppConstants.mobile2}'),
            ),
            const SizedBox(height: 8),

            // Email
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: AppRadius.roundedMd),
              tileColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              leading: const Icon(Icons.email_outlined, color: AppColors.accentGreen),
              title: const Text('البريد الإلكتروني الرسمي'),
              subtitle: const Text(AppConstants.companyEmail),
              onTap: () => _launch('mailto:${AppConstants.companyEmail}'),
            ),

            const SizedBox(height: 24),

            // Contact Form
            Text('إرسال استفسار مباشر', style: AppTypography.headlineMedium),
            const SizedBox(height: 8),
            if (_submitted)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.accentGreen.withOpacity(0.15),
                  borderRadius: AppRadius.roundedMd,
                ),
                child: const Text('تم إرسال رسالتك بنجاح، وسيتواصل معك فريق خدمة العملاء.'),
              )
            else
              Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'الاسم الكريم *'),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(labelText: 'رقم الهاتف للتواصل *'),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _msgController,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: 'نص الرسالة أو الاستفسار *'),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_nameController.text.isNotEmpty && _phoneController.text.isNotEmpty) {
                          setState(() => _submitted = true);
                        }
                      },
                      child: const Text('إرسال الرسالة'),
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
