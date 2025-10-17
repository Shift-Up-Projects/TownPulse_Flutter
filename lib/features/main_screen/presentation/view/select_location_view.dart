import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SelectLocationView extends StatefulWidget {
  const SelectLocationView({super.key});

  @override
  State<SelectLocationView> createState() => _SelectLocationViewState();
}

class _SelectLocationViewState extends State<SelectLocationView> {
  LatLng? selectedPosition;
  final mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختيار موقع النشاط'),
        actions: [
          if (selectedPosition != null)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                final mapUrl =
                    "https://www.google.com/maps/search/?api=1&query=${selectedPosition!.latitude},${selectedPosition!.longitude}";
                Navigator.pop(context, {
                  'latitude': selectedPosition!.latitude,
                  'longitude': selectedPosition!.longitude,
                  'mapUrl': mapUrl,
                });
              },
            ),
        ],
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: LatLng(24.7136, 46.6753),
          initialZoom: 10,
          onTap: (tapPosition, point) {
            setState(() {
              selectedPosition = point;
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.town_pulse2',
          ),
          if (selectedPosition != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: selectedPosition!,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 35,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
