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
        emit(ArticleUpdatingError("Article updating failed"));
      }
    });

    // * search challenges (title, location)
    on<SearchArticlesEvent>((event, emit) async {
      emit(ArticlesSearching());

      List<Article> articles = await _articleRepo.getArticles();

      final List<Article> searchResult = articles.where((article) {
        return article.articleTitle
            .toLowerCase()
            .contains(event.query.toLowerCase());
      }).toList();

      emit(ArticleDetailsLoaded(searchResult));
    });

    // * reset challenges
    on<ArticlesResetsEvent>((event, emit) async {
      List<Article> challenges = await _articleRepo.getArticles();
      emit(ArticleDetailsLoaded(challenges));
    });

    // * delete challenge from firebase
    on<DeleteArticleEvent>((event, emit) async {
      emit(ArticleDeleting());

      try {
        await _articleRepo.deleteArticle(event.aricleID);
        emit(ArticleDeleted());

        // * refreshing challenges after deletion
        add(FetchArticleEvent());
      } catch (e) {
        ArticleDeletingError("Article deleting failed");
      }
    });
  }
}
