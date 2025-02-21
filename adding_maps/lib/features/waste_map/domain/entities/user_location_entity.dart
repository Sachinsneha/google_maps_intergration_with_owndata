import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class UserLocation extends Equatable {
  final String username;
  final String address;
  final LatLng coordinates;

  const UserLocation({
    required this.username,
    required this.address,
    required this.coordinates,
  });

  @override
  List<Object?> get props => [username, address, coordinates];
}
