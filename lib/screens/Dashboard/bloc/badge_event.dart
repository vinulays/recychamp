part of 'badge_bloc.dart';

sealed class BadgeEvent extends Equatable {
  const BadgeEvent();

  @override
  List<Object> get props => [];
}

class SetBadgeEvent extends BadgeEvent {}
