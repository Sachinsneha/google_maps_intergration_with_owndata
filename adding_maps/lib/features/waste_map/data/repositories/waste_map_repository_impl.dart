import 'package:adding_maps/features/waste_map/domain/entities/bin_entity.dart';
import 'package:adding_maps/features/waste_map/domain/entities/user_location_entity.dart';
import 'package:adding_maps/features/waste_map/domain/repositories/map_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class WasteMapRepositoryImpl implements WasteMapRepository {
  @override
  Stream<Either<String, UserLocation>> getUserLocationStream() async* {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      yield left("Location services are disabled.");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        yield left("Location permissions are permanently denied.");
        return;
      }
    }

    yield* Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 2,
      ),
    ).map<Either<String, UserLocation>>((Position position) {
      String address = "Mocked Address";
      return right(UserLocation(
        username: "Sachin Bhusal",
        address: address,
        coordinates: LatLng(position.latitude, position.longitude),
      ));
    }).handleError((error) {
      return left("Failed to fetch location: $error");
    });
  }

  @override
  Future<Either<String, List<Bin>>> getBins() async {
    return right([
      Bin(
        id: "1",
        name: "Home Bin",
        location: const LatLng(43.67276, -79.40310),
        nextCollection: DateTime(2025, 1, 22, 10, 0),
        isPublic: false,
      ),
      Bin(
        id: "6",
        name: "Public Bin",
        location: const LatLng(43.6535, -79.3839),
        nextCollection: DateTime(2025, 1, 22, 10, 0),
        isPublic: true,
      ),
      Bin(
        id: "2",
        name: "Public Bin",
        location: const LatLng(43.6561, -79.3802),
        nextCollection: DateTime(2025, 1, 22, 10, 0),
        isPublic: true,
      ),
      Bin(
        id: "3",
        name: "Public Bin",
        location: const LatLng(43.7755, -79.2578),
        nextCollection: DateTime(2025, 1, 22, 10, 0),
        isPublic: true,
      ),
      Bin(
        id: "4",
        name: "Public Bin",
        location: const LatLng(43.6777, -79.6248),
        nextCollection: DateTime(2025, 1, 22, 10, 0),
        isPublic: true,
      ),
      Bin(
        id: "5",
        name: "Public Bin",
        location: const LatLng(43.6689, -79.2951),
        nextCollection: DateTime(2025, 1, 22, 10, 0),
        isPublic: true,
      ),
    ]);
  }
}
