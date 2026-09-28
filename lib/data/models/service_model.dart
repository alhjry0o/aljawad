class ServiceModel {
  final String id;
  final String title;
  final String category;
  final String iconKey;
  final String shortDescription;
  final String fullDescription;
  final String imageAsset;
  final List<String> included;
  final List<String> suitableLocations;

  const ServiceModel({
    required this.id,
    required this.title,
    required this.category,
    required this.iconKey,
    required this.shortDescription,
    required this.fullDescription,
    required this.imageAsset,
    required this.included,
    required this.suitableLocations,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'iconKey': iconKey,
      'shortDescription': shortDescription,
      'fullDescription': fullDescription,
      'imageAsset': imageAsset,
      'included': included,
      'suitableLocations': suitableLocations,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      iconKey: map['iconKey'] ?? '',
      shortDescription: map['shortDescription'] ?? '',
      fullDescription: map['fullDescription'] ?? '',
      imageAsset: map['imageAsset'] ?? '',
      included: List<String>.from(map['included'] ?? []),
      suitableLocations: List<String>.from(map['suitableLocations'] ?? []),
    );
  }
}
