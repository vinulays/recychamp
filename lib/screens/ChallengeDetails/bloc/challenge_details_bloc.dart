import 'package:bloc/bloc.dart' show Bloc;
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'challenge_details_event.dart';
part 'challenge_details_state.dart';

class ChallengeDetailsBloc
    extends Bloc<ChallengeDetailsEvent, ChallengeDetailsState> {
  ChallengeDetailsBloc()
      : super(const ChallengeDetailsInitial(isAccepted: false)) {
    // * Challenge accept event
    // todo: challenge should be added to the logged user accepted challenges list
    // todo: accepted challenge joined paritipants numbers should be increased by 1
    on<AcceptChallengeEvent>((event, emit) {
      emit(const ChallengeDetailsInitial(isAccepted: true));
    });

    // * Challenge submit event
    // todo: submission should be added to the firebase
    // todo: logged user submitted challenge list should be updated
  }
}
