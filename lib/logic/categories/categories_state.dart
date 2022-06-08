part of 'categories_bloc.dart';

@immutable
abstract class CategoriesState {}

class CategoriesInitialState extends CategoriesState {}

class CategoriesFetchedState extends CategoriesState {
  final List<Category> categories;

  CategoriesFetchedState({required this.categories});
}

class CategoriesErrorState extends CategoriesState {}
