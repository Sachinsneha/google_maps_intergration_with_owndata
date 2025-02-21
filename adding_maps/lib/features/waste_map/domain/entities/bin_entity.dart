import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class Bin extends Equatable {
  final String id;
  final String name;
  final LatLng location;
  final DateTime nextCollection;
  final bool isPublic;

  const Bin({
    required this.id,
    required this.name,
    required this.location,
    required this.nextCollection,
    required this.isPublic,
  });

  @override
  List<Object?> get props => [id, name, location, nextCollection, isPublic];
}
