part of 'shop_bloc.dart';

sealed class ShopEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchShopEvent extends ShopEvent {}

class AddShopEvent extends ShopEvent {
  final Map<String, dynamic> formData;

  AddShopEvent(this.formData);
}

class UpdateShopEvent extends ShopEvent {
  final Map<String, dynamic> formData;

  UpdateShopEvent(this.formData);
}

class DeleteShopEvent extends ShopEvent {
  final String challengeId;

  DeleteShopEvent(this.challengeId);
}

// class ApplyFiltersEvent extends ShopEvent {
//   final Set<String> filters;
//   final bool isCompleted;

//   ApplyFiltersEvent(this.filters, this.isCompleted);
// }

class SearchShopEvent extends ShopEvent {
  final String query;

  SearchShopEvent(this.query);

  @override
  List<Object> get props => [query];
}

class ResetShopEvent extends ShopEvent {}
