import 'package:adding_maps/features/waste_map/domain/usecases/get_bin_usecase.dart';
import 'package:adding_maps/features/waste_map/presentation/bloc/waste_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:adding_maps/features/waste_map/domain/repositories/map_repository.dart';
import 'package:adding_maps/features/waste_map/data/repositories/waste_map_repository_impl.dart';
import 'package:adding_maps/features/waste_map/domain/usecases/get_user_location_usecase.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<WasteMapRepository>(() => WasteMapRepositoryImpl());

  sl.registerLazySingleton(() => GetBinsUseCase(sl()));
  sl.registerLazySingleton(() => GetUserLocationUseCase(sl()));

  sl.registerFactory(() => WasteMapBloc(sl(), sl()));
}
