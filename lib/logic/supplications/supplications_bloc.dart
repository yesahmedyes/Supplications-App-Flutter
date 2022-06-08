import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supplications_app/data/models/supplication.dart';
import 'package:supplications_app/data/repos/supplicationsRepo.dart';

part 'supplications_event.dart';
part 'supplications_state.dart';

class SupplicationsBloc extends Bloc<SupplicationsEvent, SupplicationsState> {
  final SupplicationsRepo _supplicationsRepo;

  SupplicationsBloc({required SupplicationsRepo supplicationsRepo})
      : _supplicationsRepo = supplicationsRepo,
        super(SupplicationsInitialState()) {
    on<SupplicationsOpenEvent>((event, emit) async {
      final List<Supplication> supplications = await _supplicationsRepo.fetchSupplications(event.categoryId);
      add(SupplicationsSuccessEvent(supplications: supplications));
    });
    on<SupplicationsSuccessEvent>((event, emit) {
      emit(SupplicationsLoadedState(supplications: event.supplications));
    });
    on<SupplicationsFailedEvent>((event, emit) {
      emit(SupplicationsFailedState());
    });
    on<SupplicationsCloseEvent>((event, emit) {
      emit(SupplicationsInitialState());
    });
  }
}
