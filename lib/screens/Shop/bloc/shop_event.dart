part of 'shop_bloc.dart';

// sealed class ShopEvent extends Equatable {
//   const ShopEvent();

//   @override
//   List<Object> get props => [];
// }

abstract class ShopEvent {}

class LoadProducts extends ShopEvent {}

class FilterProducts extends ShopEvent {
  final String filter;

  FilterProducts(this.filter);
}
