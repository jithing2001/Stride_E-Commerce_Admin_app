class CategoryModel {
  final String category;
  final String image;
  CategoryModel({required this.category, required this.image});

  Map<String, dynamic> toJson() => {'category': category, 'image': image};
  
  static CategoryModel fromJson(Map<String, dynamic> json) => CategoryModel(
        category: json['category'],
        image: json['image'],
      );
}