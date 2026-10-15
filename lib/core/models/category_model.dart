class CategoryModel {
  final String id;
  final String title;
  final String iconName;
  final String? description;

  CategoryModel({
    required this.id,
    required this.title,
    required this.iconName,
    this.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      iconName: json['icon_name'] ?? json['iconName'] ?? 'gavel',
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon_name': iconName,
      'description': description,
    };
  }
}
