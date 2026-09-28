import 'package:flutter_test/flutter_test.dart';
import 'package:aljawad_services_app/data/models/service_model.dart';
import 'package:aljawad_services_app/data/models/request_model.dart';

void main() {
  group('Service and Request Model Tests', () {
    test('ServiceModel serialization and deserialization', () {
      const model = ServiceModel(
        id: 'test-service',
        title: 'خدمة تجريبية',
        category: 'نظافة',
        iconKey: 'test',
        shortDescription: 'وصف تجريبي',
        fullDescription: 'وصف تفصيلي كامل للخدمة',
        imageAsset: 'assets/images/services/cleaning.jpg',
        included: ['بند 1', 'بند 2'],
        suitableLocations: ['فلل', 'أبراج'],
      );

      final map = model.toMap();
      expect(map['id'], 'test-service');
      expect(map['title'], 'خدمة تجريبية');

      final fromMap = ServiceModel.fromMap(map);
      expect(fromMap.id, model.id);
      expect(fromMap.title, model.title);
      expect(fromMap.included.length, 2);
    });

    test('RequestModel serialization with dynamic specs', () {
      final req = RequestModel(
        id: 'JG-2026-9999',
        type: RequestType.service,
        serviceTitle: 'النظافة الشاملة',
        serviceId: 'deep-cleaning',
        createdAt: DateTime(2026, 10, 1),
        status: 'تم استلام الطلب',
        locationType: 'فيلا',
        city: 'الرياض',
        district: 'العليا',
        address: 'شارع الملك فهد',
        customerName: 'عبدالله الحجري',
        customerPhone: '0535091378',
        dynamicSpecs: {'الواجهة': 'زجاجية'},
      );

      final map = req.toMap();
      expect(map['id'], 'JG-2026-9999');
      expect(map['customerName'], 'عبدالله الحجري');

      final fromMap = RequestModel.fromMap(map);
      expect(fromMap.id, req.id);
      expect(fromMap.dynamicSpecs?['الواجهة'], 'زجاجية');
    });
  });
}
