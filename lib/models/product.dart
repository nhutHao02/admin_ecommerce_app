class Product {
  Product({this.id, this.name, this.images, this.description, this.price, this.categoryId, this.isfavorite});

  String? id, name, image, description, price;
  List<String>? images;
  String? categoryId;
  bool? isfavorite = false;

  Product.fromJson(Map<String, dynamic> jsonMap) {
    var images = <String>[];

    if (jsonMap['images'] != null) {
      jsonMap['images'].forEach((content) => images.add(content));
    }

    id = jsonMap['id'];
    name = jsonMap['name'];
    this.images = images;
    description = jsonMap['description'];
    price = jsonMap['price'];
    categoryId = jsonMap['categoryId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'images': images,
      'description': description,
      'price': price,
      'categoryId': categoryId,
    };
  }
}
