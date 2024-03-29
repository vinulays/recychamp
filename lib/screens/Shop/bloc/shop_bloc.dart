import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recychamp/models/product.dart';
import 'package:recychamp/repositories/shop_repository.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final ShopRepository _shopRepository;

  ShopBloc({required ShopRepository repository})
      : _shopRepository = repository,
        super(ShopInitial()) {
    on<FetchShopEvent>((event, emit) async {
      emit(ShopLoading());

      try {
        final products = await _shopRepository.getProducts();

        emit(ShopLoaded(products));
      } catch (e) {
        emit(ShopLoadedError("Shpo error: $e"));
      }
    });

    // * add challenge to firebase
    on<AddShopEvent>((event, emit) async {
      emit(ShopAdding());

      try {
        await _shopRepository.addProducts(event.formData);
        emit(ShopAdded());

        // * getting updated challenges
        add(FetchShopEvent());
      } catch (e) {
        emit(ShopAddingError("Challenge adding failed..."));
      }
    });

    on<SearchShopEvent>((event, emit) async {
      emit(ShopSearching());
      final products = await _shopRepository.getProducts();

      final List<Product> searchResult = products.where((product) {
        return product.name.toLowerCase().contains(event.query.toLowerCase());
      }).toList();

      emit(ShopLoaded(searchResult));
    });

    on<ResetShopEvent>((event, emit) async {
      final products = await _shopRepository.getProducts();
      emit(ShopLoaded(products));
    });
  }
}
