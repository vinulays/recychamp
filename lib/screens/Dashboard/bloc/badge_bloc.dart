import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recychamp/repositories/badge_repository.dart';

part 'badge_event.dart';
part 'badge_state.dart';

class BadgeBloc extends Bloc<BadgeEvent, BadgeState> {
  final BadgeRepository _badgeRepository;

  BadgeBloc({required BadgeRepository badgeRepository})
      : _badgeRepository = badgeRepository,
        super(BadgeInitial()) {
    // * get the badge name for the signed user
    on<SetBadgeEvent>((event, emit) async {
      emit(BadgeLoading());
      try {
        final submissionCount = await _badgeRepository.getUserSubmissionCount();
        final badgeName =
            await _badgeRepository.getBadgeForSubmissionCount(submissionCount);

        emit(BadgeLoaded(badgeName));
      } catch (e) {
        emit(BadgeError("Failed to fetch the badge: $e"));
      }
    });
  }
}
