
import 'package:recychamp/models/product.dart';
import 'package:recychamp/services/shop_service.dart';

class ShopRepository {
  final ShopService _shopService;

  ShopRepository({required ShopService shopService})
      : _shopService = shopService;

  Future<List<Product>> getProducts() async {
    return _shopService.getProducts();
  }


  Future<void> addProducts(Map<String, dynamic> formData) async {
    await _shopService.addProducts(formData);
  }

  // Future<void> updateChallenge(Map<String, dynamic> formData) async {
  //   await _challengeService.updateChallenge(formData);
  // }

  // Future<void> deleteChallenge(String challengeId) async {
  //   await _challengeService.deleteChallenge(challengeId);
  // }

  // Future<void> acceptChallenge(String challengeId, String userId) async {
  //   await _challengeService.acceptChallenge(challengeId, userId);
  // }

  // Future<void> submitChallenge(
  //     String userId, Map<String, dynamic> formData, String challengeId) async {
  //   await _challengeService.submitChallenge(userId, formData, challengeId);
  // }

  // Future<Submission?> getSubmission(String userId, String challengeId) async {
  //   return _challengeService.getSubmission(userId, challengeId);
  // }
}
