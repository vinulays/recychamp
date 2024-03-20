class Product {
  final String? productId;
  final String name;
  final double price;
  final String imageUrl;
  final String description;

  Product(
      {this.productId,
      required this.name,
      required this.price,
      required this.imageUrl,
      required this.description
      });
}
