part of 'shop_bloc.dart';

sealed class ShopState extends Equatable {
  const ShopState();
  
  @override
  List<Object?> get props => [];
}

final class ShopInitial extends ShopState {}
class ShopLoading extends ShopState {}

class ShopLoaded extends ShopState {
  final List<Product> products;

   ShopLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ShopLoadedError extends ShopState {}

class ShopAdding extends ShopState {}

class ShopAdded extends ShopState {}

class ShopAddingError extends ShopState {
  final String errorMessage;

  const ShopAddingError(this.errorMessage);
}

class ShopUpdating extends ShopState {}

class ShopUpdated extends ShopState {}

class ShopUpdatingError extends ShopState {
  final String errorMessage;

  ShopUpdatingError(this.errorMessage);
}

class ShopDeleting extends ShopState {}

class ShopDeleted extends ShopState {}

class ShopDeletingError extends ShopState {
  final String errorMessage;

  ShopDeletingError(this.errorMessage);
}

class ShopSearching extends ShopState {
  @override
  List<Object?> get props => [];
}