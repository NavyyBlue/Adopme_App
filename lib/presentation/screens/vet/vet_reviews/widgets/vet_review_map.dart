import 'package:adopme_frontend/models/vet/vet_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VetReviewMap extends StatefulWidget {
  final Vet vet;

  const VetReviewMap({super.key, required this.vet});
  @override
  State<VetReviewMap> createState() => _VetReviewMapState();
}

class _VetReviewMapState extends State<VetReviewMap> {
  // Controlador del mapa para interactuar con él
  late GoogleMapController _mapController;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    late final lat = widget.vet.latitude!;
    late final long = widget.vet.longitude!;
    // Definir las coordenadas del marcador
    final LatLng markerPosition = LatLng(lat, long);

    return GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: markerPosition,
          zoom: 15.0, // Nivel de zoom inicial
        ),
        markers: {
          Marker(
            markerId: const MarkerId('pets_house'),
            position: markerPosition,
            infoWindow: InfoWindow(
              title: widget.vet.name!,
              snippet: widget.vet.address!,
            ),
          ),
        },
      );
  }
}
