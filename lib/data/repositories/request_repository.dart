import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/request_model.dart';
import '../../core/constants/app_constants.dart';

abstract class IRequestRepository {
  Future<List<RequestModel>> getRequests();
  Future<void> saveRequest(RequestModel request);
  Future<void> deleteRequest(String id);
}

class LocalRequestRepository implements IRequestRepository {
  List<RequestModel> _cachedRequests = [];
  bool _isInitialized = false;

  Future<void> _init() async {
    if (_isInitialized) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(AppConstants.keySavedRequests);
      if (jsonString != null && jsonString.isNotEmpty) {
        final List<dynamic> decoded = jsonDecode(jsonString);
        _cachedRequests = decoded.map((m) => RequestModel.fromMap(m)).toList();
      } else {
        // Initial Demo seed requests so presentation has realistic data
        _cachedRequests = [
          RequestModel(
            id: 'JG-2026-8921',
            type: RequestType.service,
            serviceTitle: 'النظافة الشاملة والعميقة',
            serviceId: 'deep-cleaning',
            createdAt: DateTime.now().subtract(const Duration(days: 1)),
            status: 'تم استلام الطلب',
            locationType: 'فيلا سكنية',
            city: 'الرياض',
            district: 'حي العليا',
            address: 'شارع التحلية، فيلا 14',
            scheduledDate: '2026-10-02',
            scheduledTime: 'صباحاً (09:00 - 12:00)',
            customerName: 'سعود المحمد',
            customerPhone: '0535091378',
            notes: 'تنظيف كامل بعد أعمال الدهان والديكور الداخلي',
          ),
          RequestModel(
            id: 'QT-2026-4190',
            type: RequestType.quotation,
            serviceTitle: 'عرض سعر: تنظيف الواجهات المرتفعة',
            serviceId: 'facade-cleaning',
            createdAt: DateTime.now().subtract(const Duration(days: 2)),
            status: 'جاري إعداد العرض',
            locationType: 'برج مكتبي',
            city: 'الرياض',
            district: 'العليا',
            address: 'مساحة 3200 م² - واجهات زجاجية وكلادينج',
            customerName: 'مجموعة الأفق القابضة',
            customerPhone: '0561116199',
            notes: 'مطلوب دراسة استخدام رافعات سبايدر كرين لغسيل الواجهات المعمارية',
          ),
        ];
        await _persist();
      }
    } catch (_) {
      // fallback in-memory
    }
    _isInitialized = true;
  }

  Future<void> _persist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final listMaps = _cachedRequests.map((r) => r.toMap()).toList();
      await prefs.setString(AppConstants.keySavedRequests, jsonEncode(listMaps));
    } catch (_) {}
  }

  @override
  Future<List<RequestModel>> getRequests() async {
    await _init();
    return List.unmodifiable(_cachedRequests);
  }

  @override
  Future<void> saveRequest(RequestModel request) async {
    await _init();
    _cachedRequests.insert(0, request);
    await _persist();
  }

  @override
  Future<void> deleteRequest(String id) async {
    await _init();
    _cachedRequests.removeWhere((r) => r.id == id);
    await _persist();
  }
}
