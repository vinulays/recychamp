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
      repository.addItemToCart(event.item);

      // * refreshing the cart
      emit(CartLoadedState(repository.getCart()));
    });

    on<RemoveItemEvent>((event, emit) {
      repository.removeItemFromCart(event.itemName);

      emit(CartLoadedState(repository.getCart()));
    });

    on<UpdateItemQuantityEvent>((event, emit) {
      repository.updateItemQuantity(event.itemId, event.newQuantity);

      emit(CartLoadedState(repository.getCart()));
    });
  }
}
