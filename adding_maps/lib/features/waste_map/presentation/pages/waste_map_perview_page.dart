import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gMaps;
import 'package:adding_maps/features/waste_map/presentation/bloc/waste_state.dart';
import 'full_screen_map.dart';

class WasteMapPreview extends StatelessWidget {
  final WasteMapLoaded state;

  const WasteMapPreview({super.key, required this.state});

  void _openMapModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: FullScreenMap(state: state),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userLocation = gMaps.LatLng(
      state.userLocation.coordinates.latitude,
      state.userLocation.coordinates.longitude,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: GestureDetector(
        onTap: () => _openMapModal(context),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [
                // Embedded Google Map
                SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: gMaps.GoogleMap(
                    initialCameraPosition: gMaps.CameraPosition(
                      target: userLocation,
                      zoom: 14,
                    ),
                    markers: _buildMarkers(),
                    myLocationEnabled: false,
                    zoomControlsEnabled: false,
                    scrollGesturesEnabled: false,
                    rotateGesturesEnabled: false,
                    tiltGesturesEnabled: false,
                  ),
                ),

                // Dark overlay with text & icon
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.5),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.map, size: 60, color: Colors.white),
                      const SizedBox(height: 10),
                      Text(
                        "Tap to Explore the Waste Map",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom right floating button effect
                Positioned(
                  bottom: 15,
                  right: 15,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child:
                          Icon(Icons.fullscreen, color: Colors.blue, size: 28),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Set<gMaps.Marker> _buildMarkers() {
    return {
      for (var bin in state.bins)
        gMaps.Marker(
          markerId: gMaps.MarkerId(bin.id),
          position: gMaps.LatLng(bin.location.latitude, bin.location.longitude),
          icon: gMaps.BitmapDescriptor.defaultMarkerWithHue(bin.isPublic
              ? gMaps.BitmapDescriptor.hueBlue
              : gMaps.BitmapDescriptor.hueGreen),
          onTap: null, // Disable interaction
        ),
    };
  }
}
