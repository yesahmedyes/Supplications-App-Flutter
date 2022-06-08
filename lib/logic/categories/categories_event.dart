part of 'categories_bloc.dart';

@immutable
abstract class CategoriesEvent {}

class CategoriesFetchEvent extends CategoriesEvent {}

class CategoriesFetchSuccessEvent extends CategoriesEvent {}

class CategoriesFetchFailedEvent extends CategoriesEvent {}
