import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/providers/app_providers.dart';
import '../../../../data/models/request_model.dart';

class MyRequestsScreen extends ConsumerWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsState = ref.watch(requestsNotifierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('طلباتي ومتابعة العمليات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            tooltip: 'طلب جديد',
            onPressed: () => context.push('/service-request'),
          ),
        ],
      ),
      body: requestsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('حدث خطأ: $err')),
        data: (requests) {
          if (requests.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.assignment_outlined,
                      size: 64,
                      color: AppColors.accentGreen,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'لا توجد طلبات حتى الآن',
                      style: AppTypography.headlineLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'يمكنك إرسال طلب خدمة أو معاينة أو طلب عرض سعر وسيظهر هنا.',
                      style: AppTypography.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => context.push('/service-request'),
                      child: const Text('اطلب خدمة الآن'),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: requests.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final req = requests[index];
              return InkWell(
                onTap: () => _showRequestDetailsModal(context, req, ref),
                borderRadius: AppRadius.roundedLg,
                child: Container(
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
                        mainAxisAlignment: MainAxisAlignment.between,
                        children: [
                          Text(
                            req.id,
                            style: AppTypography.labelLarge.copyWith(
                              color: AppColors.accentGreen,
                              fontFamily: 'monospace',
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.accentGreen.withOpacity(0.15),
                              borderRadius: AppRadius.roundedSm,
                            ),
                            child: Text(
                              req.status,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.accentGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(req.serviceTitle, style: AppTypography.headlineMedium),
                      const SizedBox(height: 4),
                      Text(
                        '${req.city} - ${req.district}',
                        style: AppTypography.bodyMedium.copyWith(
                          color: isDark ? Colors.white70 : AppColors.textSecondaryLight,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'تاريخ الطلب: ${req.createdAt.year}-${req.createdAt.month.toString().padLeft(2, '0')}-${req.createdAt.day.toString().padLeft(2, '0')}',
                        style: AppTypography.caption,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showRequestDetailsModal(
      BuildContext context, RequestModel req, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.65,
          maxChildSize: 0.9,
          builder: (_, controller) {
            return SingleChildScrollView(
              controller: controller,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.between,
                    children: [
                      Text(req.id, style: AppTypography.headlineMedium),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text('الخدمة: ${req.serviceTitle}', style: AppTypography.labelLarge),
                  const SizedBox(height: 4),
                  Text('الحالة الحالية: ${req.status}'),
                  const SizedBox(height: 4),
                  Text('الموقع: ${req.city} - ${req.district} (${req.address})'),
                  const SizedBox(height: 4),
                  Text('اسم العميل: ${req.customerName} (${req.customerPhone})'),
                  if (req.scheduledDate != null) ...[
                    const SizedBox(height: 4),
                    Text('الموعد: ${req.scheduledDate} (${req.scheduledTime ?? ""})'),
                  ],
                  if (req.notes != null && req.notes!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text('الملاحظات: ${req.notes!}'),
                  ],
                  const SizedBox(height: 16),
                  Text('مسار معالجة الطلب (الجدول الزمني):', style: AppTypography.labelLarge),
                  const SizedBox(height: 8),
                  _buildTimelineItem('1. تم إنشاء الطلب محلياً بنجاح', true),
                  _buildTimelineItem('2. قيد مراجعة وتدقيق المهندس المختص', true),
                  _buildTimelineItem('3. جدولة الزيارة أو تسليم عرض الأسعار', false),
                  _buildTimelineItem('4. التنفيذ الميداني لأعمال الصيانة والتشغيل', false),
                  _buildTimelineItem('5. اكتمال الخدمة والاعتماد النهائي', false),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ref.read(requestsNotifierProvider.notifier).removeRequest(req.id);
                            Navigator.pop(ctx);
                          },
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          label: const Text('حذف الطلب', style: TextStyle(color: Colors.red)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTimelineItem(String text, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isCompleted ? AppColors.accentGreen : Colors.grey,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: AppTypography.bodyMedium)),
        ],
      ),
    );
  }
}
