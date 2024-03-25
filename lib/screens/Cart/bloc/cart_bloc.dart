import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recychamp/models/cart.dart';
import 'package:recychamp/models/cart_item.dart';
import 'package:recychamp/repositories/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;

  CartBloc({required CartRepository cartRepository})
      : repository = cartRepository,
        super(CartLoadedState(Cart(items: [], subTotal: 0, total: 0))) {
    on<AddItemEvent>((event, emit) {
      emit(CartItemAdding());

      try {
        repository.addItemToCart(event.item);
        emit(CartItemAdded());

        // * refreshing the cart
        emit(CartLoadedState(repository.getCart()));
      } catch (e) {
        emit(CartItemAddError("Cart item add error: $e"));
      }
    });

    on<RemoveItemEvent>((event, emit) {
      emit(CartItemRemoving());

      try {
        repository.removeItemFromCart(event.itemName);
        emit(CartItemRemoved());

        emit(CartLoadedState(repository.getCart()));
      } catch (e) {
        emit(CartItemRemoveError("Cart item remove error: $e"));
      }
    });

    on<AddItemQuantityEvent>((event, emit) {
      emit(CartItemQuantityAdding());
      try {
        repository.addItemQuantity(event.itemName);
        emit(CartItemQuantityAdded());

        emit(CartLoadedState(repository.getCart()));
      } catch (e) {
        emit(CartItemQuantityAddError("Cart quantity add error: $e"));
      }
    });

    on<RemoveItemQuantityEvent>((event, emit) {
      emit(CartItemQuantityRemoving());
      try {
        repository.removeItemQuantity(event.itemName);
        emit(CartItemQuantityRemoved());

        emit(CartLoadedState(repository.getCart()));
      } catch (e) {
        emit(CartItemQuantityRemoveError("Cart quantity remove error: $e"));
      }
    });

    on<UpdateItemQuantityEvent>((event, emit) {
      repository.updateItemQuantity(event.itemId, event.newQuantity);

      emit(CartLoadedState(repository.getCart()));
    });

    on<ResetCartEvent>((event, emit) {
      emit(CartResetting());
      repository.clearCart();

      emit(CartLoadedState(repository.getCart()));
    });
  }
}
