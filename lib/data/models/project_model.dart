class ProjectModel {
  final String id;
  final String title;
  final String category;
  final String serviceType;
  final String location;
  final String imageAsset;
  final String shortDescription;
  final String completionDate;
  final String scope;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.category,
    required this.serviceType,
    required this.location,
    required this.imageAsset,
    required this.shortDescription,
    required this.completionDate,
    required this.scope,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'serviceType': serviceType,
      'location': location,
      'imageAsset': imageAsset,
      'shortDescription': shortDescription,
      'completionDate': completionDate,
      'scope': scope,
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      serviceType: map['serviceType'] ?? '',
      location: map['location'] ?? '',
      imageAsset: map['imageAsset'] ?? '',
      shortDescription: map['shortDescription'] ?? '',
      completionDate: map['completionDate'] ?? '',
      scope: map['scope'] ?? '',
    );
  }
}
