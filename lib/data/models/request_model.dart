enum RequestType {
  service,
  quotation,
  inspection,
}

class RequestModel {
  final String id;
  final RequestType type;
  final String serviceTitle;
  final String serviceId;
  final DateTime createdAt;
  final String status;
  final String locationType;
  final String city;
  final String district;
  final String address;
  final String? scheduledDate;
  final String? scheduledTime;
  final String customerName;
  final String customerPhone;
  final String? notes;
  final int imagesCount;
  final List<String> imagePaths;
  final Map<String, String>? dynamicSpecs;

  const RequestModel({
    required this.id,
    required this.type,
    required this.serviceTitle,
    required this.serviceId,
    required this.createdAt,
    required this.status,
    required this.locationType,
    required this.city,
    required this.district,
    required this.address,
    this.scheduledDate,
    this.scheduledTime,
    required this.customerName,
    required this.customerPhone,
    this.notes,
    this.imagesCount = 0,
    this.imagePaths = const [],
    this.dynamicSpecs,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.name,
      'serviceTitle': serviceTitle,
      'serviceId': serviceId,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
      'locationType': locationType,
      'city': city,
      'district': district,
      'address': address,
      'scheduledDate': scheduledDate,
      'scheduledTime': scheduledTime,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'notes': notes,
      'imagesCount': imagesCount,
      'imagePaths': imagePaths,
      'dynamicSpecs': dynamicSpecs,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      id: map['id'] ?? '',
      type: RequestType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => RequestType.service,
      ),
      serviceTitle: map['serviceTitle'] ?? '',
      serviceId: map['serviceId'] ?? '',
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
      status: map['status'] ?? 'تم استلام الطلب',
      locationType: map['locationType'] ?? '',
      city: map['city'] ?? '',
      district: map['district'] ?? '',
      address: map['address'] ?? '',
      scheduledDate: map['scheduledDate'],
      scheduledTime: map['scheduledTime'],
      customerName: map['customerName'] ?? '',
      customerPhone: map['customerPhone'] ?? '',
      notes: map['notes'],
      imagesCount: map['imagesCount'] ?? 0,
      imagePaths: List<String>.from(map['imagePaths'] ?? []),
      dynamicSpecs: map['dynamicSpecs'] != null
          ? Map<String, String>.from(map['dynamicSpecs'])
          : null,
    );
  }
}
