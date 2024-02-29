import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:recychamp/models/challenge.dart';
import 'package:recychamp/repositories/challenge_repository.dart';

part 'challenges_event.dart';
part 'challenges_state.dart';

class ChallengesBloc extends Bloc<ChallengesEvent, ChallengesState> {
  final ChallengeRepository _challengeRepository;

  ChallengesBloc({required ChallengeRepository repository})
      : _challengeRepository = repository,
        super(ChallengesInitial()) {
    // * get challenges event from firebase
    on<FetchChallengesEvent>((event, emit) async {
      emit(ChallengesLoading());

      try {
        final challenges = await _challengeRepository.getChallenges();

        emit(ChallengesLoaded(challenges));
      } catch (e) {
        emit(ChallengesError());
      }
    });

    // * add challenge to firebase
    on<AddChallengeEvent>((event, emit) async {
      emit(ChallengeAdding());

      try {
        await _challengeRepository.addChallenge(event.formData);
        emit(ChallengeAdded());

        // * getting updated challenges
        add(FetchChallengesEvent());
      } catch (e) {
        emit(ChallengeAddingError("Challenge adding failed"));
      }
    });

    // * update challenge in firebase
    on<UpdateChallengeEvent>((event, emit) async {
      emit(ChallengeUpdating());

      try {
        await _challengeRepository.updateChallenge(event.formData);
        emit(ChallengeUpdated());

        // * getting updated challenges
        add(FetchChallengesEvent());
      } catch (e) {
        emit(ChallengeUpdatingError("Challenge updating failed"));
      }
    });

    // * delete challenge from firebase
    on<DeleteChallengeEvent>((event, emit) async {
      emit(ChallengeDeleting());

      try {
        await _challengeRepository.deleteChallenge(event.challengeId);
        emit(ChallengeDeleted());

        // * refreshing challenges after deletion
        add(FetchChallengesEvent());
      } catch (e) {
        ChallengeDeletingError("Challenge deleting failed");
      }
    });
  }
}
