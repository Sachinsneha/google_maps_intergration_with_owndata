import 'package:adding_maps/features/waste_map/domain/entities/user_location_entity.dart';
import 'package:adding_maps/features/waste_map/domain/repositories/map_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetUserLocationUseCase {
  final WasteMapRepository repository;

  GetUserLocationUseCase(this.repository);

  Stream<Either<String, UserLocation>> call() {
    return repository.getUserLocationStream();
  }
}
