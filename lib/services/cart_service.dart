import 'package:recychamp/models/cart.dart';
import 'package:recychamp/models/cart_item.dart';

class CartService {
  Cart cart = Cart(items: [], subTotal: 0, total: 0);

  // * Add an item to the cart
  void addItemToCart(CartItem item) {
    cart.addItem(item);
  }

  // * Remove an item from the cart
  void removeItemFromCart(String itemName) {
    cart.removeItem(itemName);
  }

  void addItemQuantity(String itemName) {
    cart.addItemQuantity(itemName);
  }

  void removeItemQuantity(String itemName) {
    cart.removeItemQuantity(itemName);
  }

  // * Update the quantity of an item in the cart
  void updateItemQuantityInCart(String itemId, int quantity) {
    cart.updateItemQuantity(itemId, quantity);
  }

  // * Get all items in the cart
  Cart getCart() {
    return cart;
  }

  // * Clear all items from the cart
  void clearCart() {
    cart.items = [];
  }
}
