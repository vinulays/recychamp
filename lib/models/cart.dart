import 'package:recychamp/models/cart_item.dart';

class Cart {
  List<CartItem> items = [];
  double subTotal;
  double total;

  Cart({required this.items, required this.subTotal, required this.total});

  void addItem(CartItem newItem) {
    // * Check if item already exists in cart
    var existingItem = items.firstWhere(
      (item) => item.name == newItem.name,
      orElse: () => CartItem(name: "", price: 0, quantity: 0, imageUrl: ""),
    );

    if (existingItem.name.isNotEmpty) {
      // * If item exists, increase quantity
      existingItem.quantity++;
    } else {
      // * If item does not exist, add it to the cart
      items.add(newItem);
    }
  }

  void removeItem(String itemName) {
    items.removeWhere((item) => item.name == itemName);
  }

  void updateItemQuantity(String itemId, int newQuantity) {
    var item = items.firstWhere(
      (item) => item.id == itemId,
      orElse: () =>
          CartItem(id: "", name: "", price: 0, quantity: 0, imageUrl: ""),
    );
    if (item.id!.isNotEmpty) {
      item.quantity = newQuantity;
    }
  }
}
