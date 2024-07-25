// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProductModel {
  int id;
  String title;
  num price;
  String category;
  String description;
  String image;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        category: json['category'],
        description: json['description'],
        image: json['image'],
      );
}
