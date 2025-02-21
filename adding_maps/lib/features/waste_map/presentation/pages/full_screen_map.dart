import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gMaps;
import 'package:adding_maps/features/waste_map/domain/entities/bin_entity.dart';
import 'package:adding_maps/features/waste_map/presentation/widgets/bin_info.dart';
import 'package:adding_maps/features/waste_map/presentation/bloc/waste_state.dart';

class FullScreenMap extends StatefulWidget {
  final WasteMapLoaded state;

  const FullScreenMap({super.key, required this.state});

  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  gMaps.GoogleMapController? _mapController;
  Bin? selectedBin;
  Set<gMaps.Polyline> _polylines = {};

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  void _drawRoute(Bin bin) async {
    final userLocation = widget.state.userLocation.coordinates;
    final binLocation = bin.location;

    List<gMaps.LatLng> routePoints = await _getRoutePoints(
      gMaps.LatLng(userLocation.latitude, userLocation.longitude),
      gMaps.LatLng(binLocation.latitude, binLocation.longitude),
    );

    setState(() {
      _polylines = {
        gMaps.Polyline(
          polylineId: const gMaps.PolylineId("user-bin-route"),
          points: routePoints,
          color: Colors.blue,
          width: 5,
        ),
      };
    });
  }

  Future<List<gMaps.LatLng>> _getRoutePoints(
      gMaps.LatLng start, gMaps.LatLng end) async {
    return [start, end]; // Simple straight-line route for now
  }

  void _zoomIn() async {
    final currentZoom = await _mapController?.getZoomLevel() ?? 15.0;
    _mapController?.animateCamera(gMaps.CameraUpdate.zoomTo(currentZoom + 1));
  }

  void _zoomOut() async {
    final currentZoom = await _mapController?.getZoomLevel() ?? 15.0;
    _mapController?.animateCamera(gMaps.CameraUpdate.zoomTo(currentZoom - 1));
  }

  @override
  Widget build(BuildContext context) {
    final userLocation = gMaps.LatLng(
      widget.state.userLocation.coordinates.latitude,
      widget.state.userLocation.coordinates.longitude,
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Waste Map")),
      body: Stack(
        children: [
          gMaps.GoogleMap(
            initialCameraPosition: gMaps.CameraPosition(
              target: userLocation,
              zoom: 15,
            ),
            onMapCreated: (controller) => _mapController = controller,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false, // Custom zoom buttons
            markers: _buildMarkers(),
            polylines: _polylines,
            mapToolbarEnabled: false, // Hide default toolbar
            compassEnabled: true, // Enable compass for better navigation
            rotateGesturesEnabled: true, // Allow rotating map
            tiltGesturesEnabled: true, // Allow 3D tilt
            scrollGesturesEnabled: true, // Allow panning
            zoomGesturesEnabled: true, // Enable pinch-to-zoom
          ),

          // Floating zoom buttons
          Positioned(
            bottom: 100,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "zoom_in",
                  backgroundColor: Colors.white,
                  onPressed: _zoomIn,
                  child: const Icon(Icons.add, color: Colors.black),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: "zoom_out",
                  backgroundColor: Colors.white,
                  onPressed: _zoomOut,
                  child: const Icon(Icons.remove, color: Colors.black),
                ),
                const SizedBox(height: 10),
                if (selectedBin != null)
                  FloatingActionButton(
                    heroTag: "route",
                    backgroundColor: Colors.white,
                    onPressed: () => _drawRoute(selectedBin!),
                    child: const Icon(Icons.directions, color: Colors.blue),
                  ),
              ],
            ),
          ),

          if (selectedBin != null)
            Positioned(
              top: 10,
              left: 20,
              right: 20,
              child: BinInfoCard(bin: selectedBin!),
            ),
        ],
      ),
    );
  }

  Set<gMaps.Marker> _buildMarkers() {
    return {
      gMaps.Marker(
        markerId: const gMaps.MarkerId("user"),
        position: gMaps.LatLng(
          widget.state.userLocation.coordinates.latitude,
          widget.state.userLocation.coordinates.longitude,
        ),
        icon: gMaps.BitmapDescriptor.defaultMarkerWithHue(
            gMaps.BitmapDescriptor.hueRed),
      ),
      for (var bin in widget.state.bins)
        gMaps.Marker(
          markerId: gMaps.MarkerId(bin.id),
          position: gMaps.LatLng(bin.location.latitude, bin.location.longitude),
          icon: gMaps.BitmapDescriptor.defaultMarkerWithHue(bin.isPublic
              ? gMaps.BitmapDescriptor.hueBlue
              : gMaps.BitmapDescriptor.hueGreen),
          onTap: () => setState(() => selectedBin = bin),
        ),
    };
  }
}
