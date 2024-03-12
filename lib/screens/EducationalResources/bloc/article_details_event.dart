part of 'article_details_bloc.dart';

sealed class ArticleDetailsEvent extends Equatable {
  const ArticleDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchArticleEvent extends ArticleDetailsEvent {}

class AddArticleEvent extends ArticleDetailsEvent {
  final Map<String, dynamic> formData;

  AddArticleEvent(this.formData);
}
