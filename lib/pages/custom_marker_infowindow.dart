import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfowindow extends StatefulWidget {
  const CustomMarkerInfowindow({super.key});

  @override
  State<CustomMarkerInfowindow> createState() => _CustomMarkerInfowindowState();
}

class _CustomMarkerInfowindowState extends State<CustomMarkerInfowindow> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latlng = const [
    LatLng(34.0150, 71.5249),
    LatLng(33.8989, 70.1008),
    LatLng(34.8065, 72.3548),
  ];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    for (int i = 0; i < _latlng.length; i++) {
      _markers.add(Marker(
          markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.defaultMarker,
          position: _latlng[i],
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
              const Text("Parachiar"),
              _latlng[i],
            );
          }));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          'Custom Marker Window',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
                target: LatLng(34.0150, 71.5249), zoom: 14),
            markers: Set<Marker>.of(_markers),
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onMapCreated: (GoogleMapController controller) {
              _customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 200,
            width: 200,
            offset: 35,
          )
        ],
      ),
    );
  }
}
