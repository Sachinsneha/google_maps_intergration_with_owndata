import 'package:adding_maps/features/waste_map/domain/usecases/get_bin_usecase.dart';
import 'package:adding_maps/features/waste_map/domain/usecases/get_user_location_usecase.dart';
import 'package:adding_maps/features/waste_map/presentation/bloc/waste_event.dart';
import 'package:adding_maps/features/waste_map/presentation/bloc/waste_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WasteMapBloc extends Bloc<WasteMapEvent, WasteMapState> {
  final GetBinsUseCase getBinsUseCase;
  final GetUserLocationUseCase getUserLocationUseCase;

  WasteMapBloc(this.getBinsUseCase, this.getUserLocationUseCase)
      : super(WasteMapInitial()) {
    on<LoadWasteMap>((event, emit) async {
      emit(WasteMapLoading());

      final binResult = await getBinsUseCase();
      binResult.fold(
        (failure) => emit(WasteMapError(failure)),
        (bins) {
          getUserLocationUseCase().listen((userResult) {
            userResult.fold(
              (failure) => add(UpdateLocationFailure(failure)),
              (userLocation) => add(UpdateLocationSuccess(userLocation, bins)),
            );
          });
        },
      );
    });

    on<UpdateLocationSuccess>((event, emit) {
      emit(WasteMapLoaded(event.userLocation, event.bins));
    });

    on<UpdateLocationFailure>((event, emit) {
      emit(WasteMapError(event.message));
    });
  }
}
