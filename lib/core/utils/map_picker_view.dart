// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapPickerView extends StatefulWidget {
//   const MapPickerView({super.key});

//   @override
//   State<MapPickerView> createState() => _MapPickerViewState();
// }

// class _MapPickerViewState extends State<MapPickerView> {
//   LatLng selectedLatLng = LatLng(24.7136, 46.6753); // Default Riyadh
//   GoogleMapController? mapController;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('اختر موقع النشاط'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.check),
//             onPressed: () {
//               // رجّع النتيجة للصفحة السابقة
//               final mapUrl =
//                   'https://maps.google.com/?q=${selectedLatLng.latitude},${selectedLatLng.longitude}';
//               Navigator.pop(context, {
//                 'latitude': selectedLatLng.latitude,
//                 'longitude': selectedLatLng.longitude,
//                 'map_url': mapUrl,
//               });
//             },
//           ),
//         ],
//       ),
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(target: selectedLatLng, zoom: 14),
//         onMapCreated: (controller) => mapController = controller,
//         onTap: (latLng) {
//           setState(() {
//             selectedLatLng = latLng;
//           });
//         },
//         markers: {
//           Marker(
//             markerId: const MarkerId('selected'),
//             position: selectedLatLng,
//           ),
//         },
//       ),
//     );
//   }
// }
