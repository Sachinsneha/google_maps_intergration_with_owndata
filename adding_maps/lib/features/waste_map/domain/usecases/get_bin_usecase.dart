import 'package:adding_maps/features/waste_map/domain/entities/bin_entity.dart';
import 'package:adding_maps/features/waste_map/domain/repositories/map_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetBinsUseCase {
  final WasteMapRepository repository;

  GetBinsUseCase(this.repository);

  Future<Either<String, List<Bin>>> call() async {
    return await repository.getBins();
  }
}
