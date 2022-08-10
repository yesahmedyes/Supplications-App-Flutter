part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class FavoritesLoadEvent extends FavoritesEvent {}

class FavoritesLoadedEvent extends FavoritesEvent {
  final Set<String> favorites;

  const FavoritesLoadedEvent({required this.favorites});

  @override
  List<Object> get props => [favorites];
}

class FavoritesToggleEvent extends FavoritesEvent {
  final String categoryId;
  final String supplicationId;

  const FavoritesToggleEvent({required this.categoryId, required this.supplicationId});

  @override
  List<Object> get props => [categoryId, supplicationId];
}
