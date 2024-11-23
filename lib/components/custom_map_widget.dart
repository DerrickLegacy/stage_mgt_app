import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMapWidget extends StatefulWidget {
  final LatLng initialPosition;
  final Set<Polyline> polylines;
  final Set<Marker> markers;
  final Function(GoogleMapController)? onMapCreated;

  const CustomMapWidget({
    Key? key,
    required this.initialPosition,
    this.polylines = const {},
    this.markers = const {},
    this.onMapCreated,
  }) : super(key: key);

  @override
  _CustomMapWidgetState createState() => _CustomMapWidgetState();
}

class _CustomMapWidgetState extends State<CustomMapWidget> {
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (controller) {
        _mapController = controller;
        if (widget.onMapCreated != null) {
          widget.onMapCreated!(controller);
        }
      },
      initialCameraPosition: CameraPosition(
        target: widget.initialPosition,
        zoom: 8.0,
      ),
      polylines: widget.polylines,
      markers: widget.markers,
    );
  }
}
