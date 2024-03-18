import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recychamp/models/article_model.dart';
import 'package:recychamp/repositories/article_repository.dart';
part 'article_details_event.dart';
part 'article_details_state.dart';

class ArticleDetailsBloc
    extends Bloc<ArticleDetailsEvent, ArticleDetailsState> {
  final ArticleRepo _articleRepo;

  ArticleDetailsBloc({required ArticleRepo repository})
      : _articleRepo = repository,
        super(ArticleDetailsInitial()) {
    // * get article event from firebase
    on<FetchArticleEvent>((event, emit) async {
      emit(ArticleDetailsLoading());

      try {
        final articles = await _articleRepo.getArticles();

        emit(ArticleDetailsLoaded(articles));
      } catch (e) {
        emit(ArticleDetailsError('Getting error'));
      }
    });

    // * add challenge to firebase
    on<AddArticleEvent>((event, emit) async {
      emit(ArticleDetailsAdding());

      try {
        await _articleRepo.addArticle(event.formData);
        emit(ArticleDetailsAdded());

        // * getting updated challenges
        add(FetchArticleEvent());
      } catch (e) {
        emit(ArticleDetailsAddingError("article adding failed"));
      }
    });

//update
    on<UpdateArticleEvent>((event, emit) async {
      emit(ArticleUpdating());

      try {
        await _articleRepo.updateArticle(event.formData);
        emit(ArticleUpdated());

        // * getting updated challenges
        add(FetchArticleEvent());
      } catch (e) {
        emit(ArticleUpdatingError("Challenge updating failed"));
      }
    });
  }
}
