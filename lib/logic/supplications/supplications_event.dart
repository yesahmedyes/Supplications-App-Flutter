part of 'supplications_bloc.dart';

@immutable
abstract class SupplicationsEvent {}

class SupplicationsOpenEvent extends SupplicationsEvent {
  final String categoryId;

  SupplicationsOpenEvent({required this.categoryId});
}

class SupplicationsFavoriteEvent extends SupplicationsEvent {
  SupplicationsFavoriteEvent();
}

class SupplicationsSuccessEvent extends SupplicationsEvent {
  final List<Supplication> supplications;

  SupplicationsSuccessEvent({required this.supplications});
}

class SupplicationsFailedEvent extends SupplicationsEvent {}

class SupplicationsCloseEvent extends SupplicationsEvent {}
