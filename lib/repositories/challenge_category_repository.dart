import 'package:recychamp/models/challenge_category.dart';
import 'package:recychamp/services/challenge_category_service.dart';

class ChallengeCategoryRepository {
  final ChallengeCategoryService _challengeCategoryService;

  ChallengeCategoryRepository(
      {required ChallengeCategoryService challengeCategoryService})
      : _challengeCategoryService = challengeCategoryService;

  Future<List<ChallengeCategory>> getChallengeCategories() async {
    return _challengeCategoryService.getChallengeCategories();
  }
}
