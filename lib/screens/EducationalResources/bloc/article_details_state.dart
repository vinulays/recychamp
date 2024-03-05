part of 'article_details_bloc.dart';

sealed class ArticleDetailsState extends Equatable {
  const ArticleDetailsState();

  @override
  List<Object> get props => [];
}

final class ArticleDetailsInitial extends ArticleDetailsState {}
