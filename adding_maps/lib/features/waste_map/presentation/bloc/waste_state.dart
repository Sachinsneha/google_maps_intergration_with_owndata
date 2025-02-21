import 'package:adding_maps/features/waste_map/domain/entities/bin_entity.dart';
import 'package:adding_maps/features/waste_map/domain/entities/user_location_entity.dart';
import 'package:equatable/equatable.dart';

abstract class WasteMapState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WasteMapInitial extends WasteMapState {}

class WasteMapLoading extends WasteMapState {}

class WasteMapLoaded extends WasteMapState {
  final UserLocation userLocation;
  final List<Bin> bins;

  WasteMapLoaded(this.userLocation, this.bins);

  @override
  List<Object?> get props => [userLocation, bins];
}

class WasteMapError extends WasteMapState {
  final String message;

  WasteMapError(this.message);

  @override
  List<Object?> get props => [message];
}
