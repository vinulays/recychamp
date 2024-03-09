import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPostsEvent extends PostEvent {}

class AddPostEvent extends PostEvent {
  final Map<String, dynamic> formData;

  AddPostEvent(this.formData);

  @override
  List<Object?> get props => [formData];
}

class UpdatePostEvent extends PostEvent {
  final Map<String, dynamic> formData;

  UpdatePostEvent(this.formData);

  @override
  List<Object?> get props => [formData];
}

class DeletePostEvent extends PostEvent {
  final String postId;

  DeletePostEvent(this.postId);

  @override
  List<Object?> get props => [postId];
}

class SearchPostsEvent extends PostEvent {
  final String query;

  SearchPostsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class ApplyPostFiltersEvent extends PostEvent {
  final Set<String> filters;

  ApplyPostFiltersEvent(this.filters);

  @override
  List<Object?> get props => [filters];
}
