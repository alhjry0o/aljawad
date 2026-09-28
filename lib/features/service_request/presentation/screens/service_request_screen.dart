import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/providers/app_providers.dart';
import '../../../../data/models/service_model.dart';
import '../../../../data/models/request_model.dart';

class ServiceRequestScreen extends ConsumerStatefulWidget {
  final String? initialServiceId;

  const ServiceRequestScreen({super.key, this.initialServiceId});

  @override
  ConsumerState<ServiceRequestScreen> createState() => _ServiceRequestScreenState();
}

class _ServiceRequestScreenState extends ConsumerState<ServiceRequestScreen> {
  int _currentStep = 0;
  ServiceModel? _selectedService;

  // Form Fields
  String _locationType = 'فيلا';
  final TextEditingController _cityController = TextEditingController(text: 'الرياض');
  final TextEditingController _districtController = TextEditingController(text: 'العليا');
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dateController =
      TextEditingController(text: '2026-10-05');
  final TextEditingController _timeController =
      TextEditingController(text: 'صباحاً (09:00 - 12:00)');
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isSuccess = false;
  String _generatedTrackingId = '';

  final List<String> _locationTypes = [
    'منزل',
    'فيلا',
    'قصر',
    'مكتب',
    'فندق',
    'مستشفى',
    'مصنع',
    'مستودع',
    'مبنى',
    'موقف',
    'منشأة أخرى',
  ];

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
    _districtController.dispose();
    _addressController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _notesController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitRequest() {
    final trackingId = 'JG-${DateTime.now().year}-${1000 + DateTime.now().millisecond}';
    final newReq = RequestModel(
      id: trackingId,
      type: RequestType.service,
      serviceTitle: _selectedService?.title ?? 'طلب خدمة عام',
      serviceId: _selectedService?.id ?? 'general',
      createdAt: DateTime.now(),
      status: 'تم استلام الطلب',
      locationType: _locationType,
      city: _cityController.text,
      district: _districtController.text,
      address: _addressController.text,
      scheduledDate: _dateController.text,
      scheduledTime: _timeController.text,
      customerName: _nameController.text.isEmpty ? 'عميل الجواد' : _nameController.text,
      customerPhone: _phoneController.text.isEmpty ? '0535091378' : _phoneController.text,
      notes: _notesController.text,
    );

    ref.read(requestsNotifierProvider.notifier).addRequest(newReq);

    setState(() {
      _generatedTrackingId = trackingId;
      _isSuccess = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final services = ref.watch(servicesListProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_isSuccess) {
      return Scaffold(
        appBar: AppBar(title: const Text('تأكيد الطلب')),
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
                  'تم حفظ الطلب في النسخة التجريبية',
                  style: AppTypography.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'رقم تتبع الطلب: $_generatedTrackingId',
                  style: AppTypography.headlineMedium.copyWith(
                    color: AppColors.accentGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'يمكنك متابعة هذا الطلب ومراجعة كافة تفاصيله من شاشة "طلباتي".',
                  style: AppTypography.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    context.go('/requests');
                  },
                  child: const Text('الانتقال إلى طلباتي'),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () {
                    context.go('/');
                  },
                  child: const Text('العودة للرئيسية'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('طلب خدمة جديدة'),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 3) {
            setState(() => _currentStep += 1);
          } else {
            _submitRequest();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep -= 1);
          } else {
            context.pop();
          }
        },
        controlsBuilder: (context, details) {
          final isLast = _currentStep == 3;
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: Text(isLast ? 'تأكيد وحفظ الطلب' : 'متابعة'),
                ),
                const SizedBox(width: 12),
                if (_currentStep > 0)
                  OutlinedButton(
                    onPressed: details.onStepCancel,
                    child: const Text('السابق'),
                  ),
              ],
            ),
          );
        },
        steps: [
          // Step 1: الخدمة ونوع العقار
          Step(
            title: const Text('الخدمة ونوع المنشأة'),
            isActive: _currentStep >= 0,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<ServiceModel>(
                  value: _selectedService,
                  decoration: const InputDecoration(labelText: 'اختر الخدمة'),
                  items: services.map((s) {
                    return DropdownMenuItem(value: s, child: Text(s.title));
                  }).toList(),
                  onChanged: (val) => setState(() => _selectedService = val),
                ),
                const SizedBox(height: 16),
                const Text('نوع المنشأة / العقار:'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _locationTypes.map((type) {
                    final isSel = _locationType == type;
                    return ChoiceChip(
                      label: Text(type),
                      selected: isSel,
                      selectedColor: AppColors.accentGreen,
                      labelStyle: TextStyle(
                        color: isSel ? Colors.white : null,
                        fontWeight: FontWeight.bold,
                      ),
                      onSelected: (val) {
                        if (val) setState(() => _locationType = type);
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Step 2: الموقع
          Step(
            title: const Text('الموقع والموعد'),
            isActive: _currentStep >= 1,
            content: Column(
              children: [
                TextField(
                  controller: _cityController,
                  decoration: const InputDecoration(labelText: 'المدينة'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _districtController,
                  decoration: const InputDecoration(labelText: 'الحي'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'العنوان التفصيلي'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(labelText: 'التاريخ المفضل (YYYY-MM-DD)'),
                ),
              ],
            ),
          ),

          // Step 3: الصور والمواصفات
          Step(
            title: const Text('المواصفات والصور'),
            isActive: _currentStep >= 2,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'مواصفات أو تفاصيل الطلب',
                    hintText: 'اكتب المساحة التقريبية أو طبيعة الأعمال...',
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم تفعيل محاكي رفع الصور وإرفاق ملفات الموقع بنجاح'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_a_photo_outlined),
                  label: const Text('إرفاق صور الموقع (كاميرا / معرض الصور)'),
                ),
              ],
            ),
          ),

          // Step 4: بيانات الاتصال والمراجعة
          Step(
            title: const Text('بيانات العميل والتأكيد'),
            isActive: _currentStep >= 3,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'الاسم الكريم / اسم المنشأة *'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'رقم الهاتف للتواصل * (05xxxxxxxx)'),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                    borderRadius: AppRadius.roundedMd,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ملخص الطلب:', style: AppTypography.labelLarge),
                      const SizedBox(height: 4),
                      Text('الخدمة: ${_selectedService?.title}'),
                      Text('العقار: $_locationType'),
                      Text('الموقع: ${_cityController.text} - ${_districtController.text}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
