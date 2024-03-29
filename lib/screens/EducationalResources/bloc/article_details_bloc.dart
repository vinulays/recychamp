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
    on<FetchArticleEvent>((event, emit) async {
      // article get from firebase
      emit(ArticleDetailsLoading());

      try {
        final articles = await _articleRepo.getArticles();

        emit(ArticleDetailsLoaded(articles));
      } catch (e) {
        emit(ArticleDetailsError('Getting error'));
      }
    });

    on<AddArticleEvent>((event, emit) async {
      // add new to firebase
      emit(ArticleDetailsAdding());

      try {
        await _articleRepo.addArticle(event.formData);
        emit(ArticleDetailsAdded());

        add(FetchArticleEvent());
      } catch (e) {
        emit(ArticleDetailsAddingError("article adding failed"));
      }
    });

    on<UpdateArticleEvent>((event, emit) async {
      // update article
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

    on<SearchArticlesEvent>((event, emit) async {
      // search using type and title
      emit(ArticlesSearching());

      List<Article> articles = await _articleRepo.getArticles();

      final List<Article> searchResult = articles.where((article) {
        return article.articleTitle
                .toLowerCase()
                .contains(event.query.toLowerCase()) ||
            article.articleType
                .toLowerCase()
                .contains(event.query.toLowerCase());
      }).toList();

      emit(ArticleDetailsLoaded(searchResult));
    });

    on<ArticlesResetsEvent>((event, emit) async {
      // reset articles
      List<Article> challenges = await _articleRepo.getArticles();
      emit(ArticleDetailsLoaded(challenges));
    });
  }
}
