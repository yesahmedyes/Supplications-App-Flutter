import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supplications_app/data/repos/supplicationsRepo.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final SupplicationsRepo _supplicationsRepo;
  StreamSubscription? subscription;

  FavoritesBloc({required SupplicationsRepo supplicationsRepo})
      : _supplicationsRepo = supplicationsRepo,
        super(FavoritesInitialState()) {
    on<FavoritesLoadEvent>((event, emit) {
      subscription ??= _supplicationsRepo.favoritesStream.listen((favorites) {
        add(FavoritesLoadedEvent(favorites: favorites));
      });

      _supplicationsRepo.fetchFavorites();
    });
    on<FavoritesLoadedEvent>((event, emit) {
      emit(FavoritesInitialState());
      emit(FavoritesLoadedState(favorites: event.favorites));
    });
    on<FavoritesToggleEvent>((event, emit) {
      _supplicationsRepo.toggleFavorite(event.categoryId, event.supplicationId);
    });
  }
}
