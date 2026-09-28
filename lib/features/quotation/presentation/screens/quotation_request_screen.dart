import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/providers/app_providers.dart';
import '../../../../data/models/service_model.dart';
import '../../../../data/models/request_model.dart';

class QuotationRequestScreen extends ConsumerStatefulWidget {
  final String? initialServiceId;

  const QuotationRequestScreen({super.key, this.initialServiceId});

  @override
  ConsumerState<QuotationRequestScreen> createState() => _QuotationRequestScreenState();
}

class _QuotationRequestScreenState extends ConsumerState<QuotationRequestScreen> {
  ServiceModel? _selectedService;
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _floorsController = TextEditingController();
  final TextEditingController _facadeTypeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  bool _isSuccess = false;
  String _trackingId = '';

  @override
  void initState() {
    super.initState();
    final services = ref.read(servicesListProvider);
    if (widget.initialServiceId != null) {
      try {
        _selectedService =
            services.firstWhere((s) => s.id == widget.initialServiceId);
      } catch (_) {}
    }
    _selectedService ??= services.isNotEmpty ? services.first : null;
  }

  @override
  void dispose() {
    _areaController.dispose();
    _floorsController.dispose();
    _facadeTypeController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submitQuotation() {
    final tid = 'QT-${DateTime.now().year}-${1000 + DateTime.now().millisecond}';
    final newReq = RequestModel(
      id: tid,
      type: RequestType.quotation,
      serviceTitle: 'عرض سعر: ${_selectedService?.title ?? "خدمات عامة"}',
      serviceId: _selectedService?.id ?? 'general',
      createdAt: DateTime.now(),
      status: 'جاري إعداد العرض',
      locationType: 'منشأة تجارية / سكنية',
      city: 'الرياض',
      district: 'العليا',
      address: 'المساحة: ${_areaController.text} م² - ${_floorsController.text} أدوار',
      customerName: _nameController.text.isEmpty ? 'عميل الجواد' : _nameController.text,
      customerPhone: _phoneController.text.isEmpty ? '0535091378' : _phoneController.text,
      notes: _notesController.text,
    );

    ref.read(requestsNotifierProvider.notifier).addRequest(newReq);

    setState(() {
      _trackingId = tid;
      _isSuccess = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final services = ref.watch(servicesListProvider);

    if (_isSuccess) {
      return Scaffold(
        appBar: AppBar(title: const Text('طلب عرض سعر')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.accentGreen,
                  size: 64,
                ),
                const SizedBox(height: 16),
                Text(
                  'تم حفظ طلب عرض السعر في النسخة التجريبية',
                  style: AppTypography.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'رقم تتبع العرض: $_trackingId',
                  style: AppTypography.headlineMedium.copyWith(
                    color: AppColors.accentGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.go('/requests'),
                  child: const Text('عرض في طلباتي'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('طلب عرض سعر رسمي'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<ServiceModel>(
              value: _selectedService,
              decoration: const InputDecoration(labelText: 'الخدمة المراد تسعيرها'),
              items: services.map((s) {
                return DropdownMenuItem(value: s, child: Text(s.title));
              }).toList>,
              onChanged: (val) => setState(() => _selectedService = val),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _areaController,
              decoration: const InputDecoration(
                labelText: 'المساحة التقريبية (متر مربع)',
                hintText: 'مثال: 1200 م²',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _floorsController,
              decoration: const InputDecoration(
                labelText: 'عدد الأدوار / الارتفاع',
                hintText: 'مثال: 6 أدوار',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _facadeTypeController,
              decoration: const InputDecoration(
                labelText: 'نوع الخامة / الواجهة / الأرضية',
                hintText: 'زجاج، كلادينج، إيبوكسي، رخام...',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'اسم المسؤول أو اسم المنشأة *',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'رقم الهاتف للتواصل *',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'ملاحظات أو اشتراطات فنية',
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitQuotation,
                child: const Text('إرسال طلب عرض السعر'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
