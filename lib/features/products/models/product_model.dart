class ProductModel {
  int id;
  String title;
  String description;
  String category;
  String thumbnail;
  double price;

  ProductModel({
    required this.category,
    required this.description,
    required this.id,
    required this.price,
    required this.thumbnail,
    required this.title,
  });

  factory ProductModel.fromMap(map) {
    return ProductModel(
      category: map["category"],
      description: map["description"],
      id: map["id"],
      price: map["price"],
      thumbnail: map["thumbnail"],
      title: map["title"],
    );
  }
}
