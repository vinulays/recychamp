part of 'badge_bloc.dart';

sealed class BadgeState extends Equatable {
  @override
  List<Object> get props => [];
}

final class BadgeInitial extends BadgeState {}

class BadgeLoading extends BadgeState {}

class BadgeLoaded extends BadgeState {
  final String badge;

  BadgeLoaded(this.badge);
}

class BadgeError extends BadgeState {
  final String message;

  BadgeError(this.message);
}
