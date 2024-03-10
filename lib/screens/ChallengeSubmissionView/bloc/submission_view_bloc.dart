import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recychamp/models/submission.dart';
import 'package:recychamp/repositories/challenge_repository.dart';

part 'submission_view_event.dart';
part 'submission_view_state.dart';

class SubmissionViewBloc
    extends Bloc<SubmissionViewEvent, SubmissionViewState> {
  final ChallengeRepository _challengeRepository;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SubmissionViewBloc({required ChallengeRepository repository})
      : _challengeRepository = repository,
        super(SubmissionViewInitial()) {
    // * fetch submission event
    on<FetchSubmissionEvent>((event, emit) async {
      emit(SubmissionLoading());
      try {
        final User? user = _auth.currentUser;
        if (user != null) {
          final userId = user.uid;
          final Submission? submission = await _challengeRepository
              .getSubmission(userId, event.challengeId);

          if (submission != null) {
            emit(SubmissionLoaded(submission));
          }
        }
      } catch (e) {
        emit(SubmissionLoadingError("Failed to load the submission: $e"));
      }
    });
  }
}
