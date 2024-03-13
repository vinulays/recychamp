import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recychamp/models/challenge.dart';
import 'package:recychamp/repositories/challenge_repository.dart';
import 'package:recychamp/utils/challenge_categories.dart';

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

    // * filter challenges locally
    on<ApplyFiltersEvent>((event, emit) async {
      try {
        User? user = FirebaseAuth.instance.currentUser;

        List<Challenge> challenges = await _challengeRepository.getChallenges();

        List<Challenge> filteredChallenges = challenges.where((challenge) {
          if (event.isCompleted) {
            return (event.filters.isEmpty ||
                    event.filters.contains(challengeCategories
                        .firstWhere(
                            (category) => category.id == challenge.categoryId)
                        .name)) &&
                challenge.submittedParticipants.contains(user?.uid);
          } else {
            return (event.filters.isEmpty ||
                event.filters.contains(challengeCategories
                    .firstWhere(
                        (category) => category.id == challenge.categoryId)
                    .name));
          }
        }).toList();

        emit(ChallengesLoaded(filteredChallenges));
      } catch (e) {
        throw Exception("Challenge filtering failed: $e");
      }
    });

    // * reset challenges
    on<ResetChallengesEvent>((event, emit) async {
      List<Challenge> challenges = await _challengeRepository.getChallenges();
      emit(ChallengesLoaded(challenges));
    });

    // * search challenges (title, location)
    on<SearchChallengesEvent>((event, emit) async {
      emit(ChallengesSearching());

      List<Challenge> challenges = await _challengeRepository.getChallenges();

      final List<Challenge> searchResult = challenges.where((challenge) {
        return challenge.title
                .toLowerCase()
                .contains(event.query.toLowerCase()) ||
            challenge.location
                .toLowerCase()
                .contains(event.query.toLowerCase());
      }).toList();

      emit(ChallengesLoaded(searchResult));
    });
  }
}
