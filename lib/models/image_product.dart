class ProductImage {
  int idImage;
  String pathImage;

  ProductImage({
    required this.idImage,
    required this.pathImage,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      idImage: json['id_image'],
      pathImage: json['path_image'],
    );
  }
}
