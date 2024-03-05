import 'package:bloc/bloc.dart' show Bloc;
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:recychamp/repositories/challenge_repository.dart';

part 'challenge_details_event.dart';
part 'challenge_details_state.dart';

class ChallengeDetailsBloc
    extends Bloc<ChallengeDetailsEvent, ChallengeDetailsState> {
  final ChallengeRepository _challengeRepository;

  ChallengeDetailsBloc({required ChallengeRepository repository})
      : _challengeRepository = repository,
        super(ChallengeDetailsInitial()) {
    // * Challenge accept event
    // todo: challenge should be added to the firebase logged user accepted challenges list
    // todo: accepted challenge joined paritipants numbers should be increased by 1
    on<AcceptChallengeEvent>((event, emit) {
      emit(ChallengeAccepting());
      // * rest of the code
    });

    // * Challenge submit event
    // todo: submission should be added to the firebase
    // todo: logged user submitted challenge list should be updated
    on<SubmitChallengeEvent>((event, emit) {
      emit(ChallengeSubmitting());
    });
  }
}
