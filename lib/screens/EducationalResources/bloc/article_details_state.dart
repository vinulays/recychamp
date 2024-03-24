part of 'article_details_bloc.dart';

sealed class ArticleDetailsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ArticleDetailsInitial extends ArticleDetailsState {}

class ArticleDetailsLoading extends ArticleDetailsState {}

class ArticleDetailsLoaded extends ArticleDetailsState {
  final List<Article> articles;

  ArticleDetailsLoaded(this.articles);

  @override
  List<Object> get props => [articles];
}

class ArticleDetailsError extends ArticleDetailsState {
  final String errorMessage;

  ArticleDetailsError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class ArticleDetailsAdding extends ArticleDetailsState {}

class ArticleDetailsAdded extends ArticleDetailsState {}

class ArticleDetailsAddingError extends ArticleDetailsState {
  final String errorMessage;

  ArticleDetailsAddingError(this.errorMessage);
}

class ArticleUpdating extends ArticleDetailsState {}

class ArticleUpdated extends ArticleDetailsState {}

class ArticleUpdatingError extends ArticleDetailsState {
  final String errorMessage;

  ArticleUpdatingError(this.errorMessage);
}

class ArticlesSearching extends ArticleDetailsState {
  @override
  List<Object> get props => [];
}

class ArticleDeleting extends ArticleDetailsState {}

class ArticleDeleted extends ArticleDetailsState {}

class ArticleDeletingError extends ArticleDetailsState {
  final String errorMessageArticle;

  ArticleDeletingError(this.errorMessageArticle);
}
