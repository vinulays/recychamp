import 'package:recychamp/models/cart.dart';
import 'package:recychamp/models/cart_item.dart';
import 'package:recychamp/services/cart_service.dart';

class CartRepository {
  final CartService cartService;

  CartRepository({required this.cartService});

  // * Add an item to the cart
  void addItemToCart(CartItem item) {
    cartService.addItemToCart(item);
  }

  // * Remove an item from the cart
  void removeItemFromCart(String itemName) {
    cartService.removeItemFromCart(itemName);
  }

  // * Update the quantity of an item in the cart
  void updateItemQuantity(String itemId, int quantity) {
    cartService.updateItemQuantityInCart(itemId, quantity);
  }

  // * Get all items in the cart
  Cart getCart() {
    return cartService.getCart();
  }

  // * Clear all items from the cart
  void clearCart() {
    cartService.clearCart();
  }
}
