import 'package:bloc/bloc.dart' show Bloc;
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:recychamp/models/challenge.dart';
import 'package:recychamp/repositories/challenge_repository.dart';

part 'challenge_details_event.dart';
part 'challenge_details_state.dart';

class ChallengeDetailsBloc
    extends Bloc<ChallengeDetailsEvent, ChallengeDetailsState> {
  final ChallengeRepository _challengeRepository;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ChallengeDetailsBloc({required ChallengeRepository repository})
      : _challengeRepository = repository,
        super(ChallengeDetailsInitial()) {
    // * fetch challenge by id event
    on<FetchChallengeDetailsEvent>((event, emit) async {
      emit(ChallengeLoading());
      try {
        final Challenge challenge =
            await _challengeRepository.getChallengeById(event.challengeID);
        emit(ChallengeLoaded(challenge));
      } catch (e) {
        emit(ChallengeLoadingError("Failed to fetch the challenge $e"));
      }
    });

    // * Challenge accept event
    // todo: user id should be added to the  accepted challenge's user list
    on<AcceptChallengeEvent>((event, emit) async {
      emit(ChallengeAccepting());

      try {
        final User? user = _auth.currentUser;
        if (user != null) {
          final userId = user.uid;

          await _challengeRepository.acceptChallenge(event.challengeID, userId);
          emit(ChallengeAccepted());

          // * Refreshing the challenge after accepting
          add(FetchChallengeDetailsEvent(event.challengeID));
        } else {
          emit(ChallengeAcceptingError("User not authenticated"));
        }
      } catch (e) {
        emit(ChallengeAcceptingError("Failed to accept challenge $e"));
      }
    });

    // * Challenge submit event
    // todo: submission should be added to the firebase including the challenge id, user id
    on<SubmitChallengeEvent>((event, emit) {
      emit(ChallengeSubmitting());
    });
  }
}
