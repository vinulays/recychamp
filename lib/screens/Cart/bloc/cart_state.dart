part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoadedState extends CartState {
  final Cart cart;

  CartLoadedState(this.cart);
  @override
  List<Object> get props => [cart];
}

class CartErrorState extends CartState {
  final String errorMessage;

  CartErrorState(this.errorMessage);
}

class CartItemAdding extends CartState {}

class CartItemAdded extends CartState {}

class CartItemAddError extends CartState {
  final String errorMessage;

  CartItemAddError(this.errorMessage);
}

class CartItemRemoving extends CartState {}

class CartItemRemoved extends CartState {}

class CartItemRemoveError extends CartState {
  final String errorMessage;

  CartItemRemoveError(this.errorMessage);
}

class CartItemQuantityAdding extends CartState {}

class CartItemQuantityAdded extends CartState {}

class CartItemQuantityAddError extends CartState {
  final String errorMessage;

  CartItemQuantityAddError(this.errorMessage);
}

class CartItemQuantityRemoving extends CartState {}

class CartItemQuantityRemoved extends CartState {}

class CartItemQuantityRemoveError extends CartState {
  final String errorMessage;

  CartItemQuantityRemoveError(this.errorMessage);
}
