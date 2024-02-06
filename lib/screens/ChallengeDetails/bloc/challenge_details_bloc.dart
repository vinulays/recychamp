import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'challenge_details_event.dart';
part 'challenge_details_state.dart';

class ChallengeDetailsBloc
    extends Bloc<ChallengeDetailsEvent, ChallengeDetailsState> {
  ChallengeDetailsBloc()
      : super(const ChallengeDetailsInitial(isAccepted: false)) {
    on<AcceptChallengeEvent>((event, emit) {
      emit(const ChallengeDetailsInitial(isAccepted: true));
    });
  }
}
