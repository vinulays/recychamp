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
    on<AcceptChallengeEvent>((event, emit) {
      emit(const ChallengeDetailsInitial(isAccepted: true));
    });
  }
}
