part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitialState extends FavoritesState {}

class FavoritesLoadedState extends FavoritesState {
  final Set<String> favorites;

  const FavoritesLoadedState({required this.favorites});

  @override
  List<Object> get props => [favorites];
}

class FavoritesFailedState extends FavoritesState {}
