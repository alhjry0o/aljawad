import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/providers/app_providers.dart';
import '../../../../data/models/service_model.dart';
import '../../../../data/models/request_model.dart';

class InspectionRequestScreen extends ConsumerStatefulWidget {
  final String? initialServiceId;

  const InspectionRequestScreen({super.key, this.initialServiceId});

  @override
  ConsumerState<InspectionRequestScreen> createState() =>
      _InspectionRequestScreenState();
}

class _InspectionRequestScreenState
    extends ConsumerState<InspectionRequestScreen> {
  ServiceModel? _selectedService;
  final TextEditingController _cityController =
      TextEditingController(text: 'الرياض');
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dateController =
      TextEditingController(text: '2026-10-06');
  final TextEditingController _timeController =
      TextEditingController(text: 'صباحاً (10:00)');
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
    _cityController.dispose();
    _addressController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submitInspection() {
    final tid = 'IN-${DateTime.now().year}-${1000 + DateTime.now().millisecond}';
    final newReq = RequestModel(
      id: tid,
      type: RequestType.inspection,
      serviceTitle: 'طلب معاينة: ${_selectedService?.title ?? "معاينة عامة"}',
      serviceId: _selectedService?.id ?? 'general',
      createdAt: DateTime.now(),
      status: 'بانتظار المعاينة',
      locationType: 'معاينة ميدانية للموقع',
      city: _cityController.text,
      district: _addressController.text,
      address: _addressController.text,
      scheduledDate: _dateController.text,
      scheduledTime: _timeController.text,
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
        appBar: AppBar(title: const Text('طلب معاينة ميدانية')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.calendar_month_rounded,
                  color: AppColors.accentGreen,
                  size: 64,
                ),
                const SizedBox(height: 16),
                Text(
                  'تم حفظ موعد المعاينة في النسخة التجريبية',
                  style: AppTypography.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'رقم تتبع المعاينة: $_trackingId',
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
        title: const Text('حجز موعد معاينة ميدانية'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<ServiceModel>(
              value: _selectedService,
              decoration: const InputDecoration(labelText: 'الخدمة المراد معاينتها'),
              items: services.map((s) {
                return DropdownMenuItem(value: s, child: Text(s.title));
              }).toList(),
              onChanged: (val) => setState(() => _selectedService = val),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(labelText: 'المدينة'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'العنوان أو الحي التفصيلي *'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'تاريخ الزيارة المقترح'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(labelText: 'الوقت المفضل'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'الاسم الكريم *'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'رقم الجوال *'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _notesController,
              maxLines: 2,
              decoration: const InputDecoration(labelText: 'ملاحظات المعاينة'),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitInspection,
                child: const Text('تأكيد حجز المعاينة'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
