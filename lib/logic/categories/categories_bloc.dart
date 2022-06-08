import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supplications_app/data/models/category.dart';
import 'package:supplications_app/data/repos/supplicationsRepo.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final SupplicationsRepo _supplicationsRepo;

  CategoriesBloc({required SupplicationsRepo supplicationsRepo})
      : _supplicationsRepo = supplicationsRepo,
        super(CategoriesInitialState()) {
    on<CategoriesFetchEvent>((event, emit) async {
      final List<Category> _categories = await _supplicationsRepo.fetchCategories();
      emit(CategoriesFetchedState(categories: _categories));
    });
    on<CategoriesFetchSuccessEvent>((event, emit) {});
    on<CategoriesFetchFailedEvent>((event, emit) {});
  }
}
