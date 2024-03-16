import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:recychamp/models/post.dart';

@immutable
abstract class PostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;

  PostLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class PostError extends PostState {
  final String errorMessage;

  PostError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class PostAdding extends PostState {}

class PostAdded extends PostState {}

class PostAddingError extends PostState {
  final String errorMessage;

  PostAddingError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class PostUpdating extends PostState {}

class PostUpdated extends PostState {}

class PostUpdatingError extends PostState {
  final String errorMessage;

  PostUpdatingError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class PostDeleting extends PostState {}

class PostDeleted extends PostState {}

class PostDeletingError extends PostState {
  final String errorMessage;

  PostDeletingError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class PostsSearching extends PostState {
  @override
  List<Object?> get props => [];
}
