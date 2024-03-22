class CartItem {
  final String? id;
  final String name;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem({
    this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });
}
