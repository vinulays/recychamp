import 'package:recychamp/models/challenge.dart';
import 'package:recychamp/services/challenge_service.dart';

class ChallengeRepository {
  final ChallengeService _challengeService;

  ChallengeRepository({required ChallengeService challengeService})
      : _challengeService = challengeService;

  Future<List<Challenge>> getChallenges() async {
    return _challengeService.getChallenges();
  }
}
