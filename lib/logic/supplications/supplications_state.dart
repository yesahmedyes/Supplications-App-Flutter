part of 'supplications_bloc.dart';

@immutable
abstract class SupplicationsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SupplicationsInitialState extends SupplicationsState {}

class SupplicationsLoadedState extends SupplicationsState {
  final List<Supplication> supplications;

  SupplicationsLoadedState({required this.supplications});

  @override
  List<Object?> get props => [supplications];
}

class SupplicationsFailedState extends SupplicationsState {}
