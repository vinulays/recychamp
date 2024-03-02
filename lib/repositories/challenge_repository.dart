import 'package:recychamp/models/challenge.dart';
import 'package:recychamp/services/challenge_service.dart';

class ChallengeRepository {
  final ChallengeService _challengeService;

  ChallengeRepository({required ChallengeService challengeService})
      : _challengeService = challengeService;

  Future<List<Challenge>> getChallenges() async {
    return _challengeService.getChallenges();
  }

  Future<void> addChallenge(Map<String, dynamic> formData) async {
    await _challengeService.addChallenge(formData);
  }

  Future<void> updateChallenge(Map<String, dynamic> formData) async {
    await _challengeService.updateChallenge(formData);
  }

  Future<void> deleteChallenge(String challengeId) async {
    await _challengeService.deleteChallenge(challengeId);
  }
}
