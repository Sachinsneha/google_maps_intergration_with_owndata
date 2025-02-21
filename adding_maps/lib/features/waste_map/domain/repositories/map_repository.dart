import 'package:adding_maps/features/waste_map/domain/entities/bin_entity.dart';
import 'package:adding_maps/features/waste_map/domain/entities/user_location_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class WasteMapRepository {
  Stream<Either<String, UserLocation>> getUserLocationStream();
  Future<Either<String, List<Bin>>> getBins();
}
