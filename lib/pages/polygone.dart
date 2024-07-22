import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Polygone extends StatefulWidget {
  const Polygone({super.key});

  @override
  State<Polygone> createState() => _PolygoneState();
}

class _PolygoneState extends State<Polygone> {
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(34.0150, 71.5249),
    zoom: 14,
  );
  final List<LatLng> points = const [
    LatLng(34.00103782676117, 71.54470331720086),
    LatLng(34.002870, 71.542794),
    LatLng(33.998720, 71.538373),
    LatLng(34.002497, 71.556162),
    LatLng(34.00103782676117, 71.54470331720086),
  ];
  final Set<Polygon> _polygone = HashSet<Polygon>();
  @override
  void initState() {
    super.initState();
    _polygone.add(
      Polygon(
        polygonId: PolygonId('1'),
        points: points,
        fillColor: Colors.red.withOpacity(0.3),
        strokeColor: Colors.blue,
        strokeWidth: 4,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text("Polykone", style: TextStyle(color: Colors.white)),
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        myLocationButtonEnabled: true,
        polygons: _polygone,
        myLocationEnabled: true,
      ),
    );
  }
}
