import 'package:recychamp/services/badge_service.dart';

class BadgeRepository {
  final BadgeService _badgeService;

  BadgeRepository({required BadgeService badgeService})
      : _badgeService = badgeService;

  Future<int> getUserSubmissionCount() async {
    return _badgeService.getUserSubmissionCount();
  }

  Future<String> getBadgeForSubmissionCount(int submissionCount) async {
    return _badgeService.getBadgeForSubmissionCount(submissionCount);
  }
}
