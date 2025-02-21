import 'package:adding_maps/features/waste_map/domain/entities/bin_entity.dart';
import 'package:adding_maps/features/waste_map/domain/entities/user_location_entity.dart';
import 'package:equatable/equatable.dart';

abstract class WasteMapEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadWasteMap extends WasteMapEvent {}

class UpdateLocationSuccess extends WasteMapEvent {
  final UserLocation userLocation;
  final List<Bin> bins;

  UpdateLocationSuccess(this.userLocation, this.bins);

  @override
  List<Object> get props => [userLocation, bins];
}

class UpdateLocationFailure extends WasteMapEvent {
  final String message;

  UpdateLocationFailure(this.message);

  @override
  List<Object> get props => [message];
}
