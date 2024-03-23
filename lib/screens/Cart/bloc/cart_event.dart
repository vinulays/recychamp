part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCartEvent extends CartEvent {}

class AddItemEvent extends CartEvent {
  final CartItem item;

  AddItemEvent(this.item);
}

class RemoveItemEvent extends CartEvent {
  final String itemName;

  RemoveItemEvent(this.itemName);
}

class AddItemQuantityEvent extends CartEvent {
  final String itemName;

  AddItemQuantityEvent(this.itemName);
}

class RemoveItemQuantityEvent extends CartEvent {
  final String itemName;

  RemoveItemQuantityEvent(this.itemName);
}

class UpdateItemQuantityEvent extends CartEvent {
  final String itemId;
  final int newQuantity;

  UpdateItemQuantityEvent(this.itemId, this.newQuantity);
}
