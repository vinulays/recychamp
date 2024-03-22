part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

class CartLoadedState extends CartState {
  final Cart cart;

  CartLoadedState(this.cart);
}

class CartErrorState extends CartState {
  final String errorMessage;

  CartErrorState(this.errorMessage);
}
