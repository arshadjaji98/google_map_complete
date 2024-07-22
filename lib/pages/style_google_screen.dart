import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StyleGoogleScreen extends StatefulWidget {
  const StyleGoogleScreen({super.key});

  @override
  State<StyleGoogleScreen> createState() => _StyleGoogleScreenState();
}

class _StyleGoogleScreenState extends State<StyleGoogleScreen> {
  String mapTheme = '';
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(34.0150, 71.5249),
    zoom: 14,
  );

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/map_theme/standard_theme.json')
        .then((value) {
      mapTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.more_horiz),
              iconColor: Colors.white,
              iconSize: 25,
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {
                    _controller.future.then((value) {
                      DefaultAssetBundle.of(context)
                          .loadString('assets/map_theme/silver_theme.json')
                          .then((string) {
                        value.setMapStyle(string);
                      });
                    });
                  },
                  child: const Text('Silver'),
                ),
                PopupMenuItem(
                  onTap: () {
                    _controller.future.then((value) {
                      DefaultAssetBundle.of(context)
                          .loadString('assets/map_theme/night_theme.json')
                          .then((string) {
                        value.setMapStyle(string);
                      });
                    });
                  },
                  child: const Text('Night'),
                ),
                PopupMenuItem(
                  onTap: () {
                    _controller.future.then((value) {
                      DefaultAssetBundle.of(context)
                          .loadString('assets/map_theme/retro_theme.json')
                          .then((string) {
                        value.setMapStyle(string);
                      });
                    });
                  },
                  child: const Text('Retro'),
                ),
                PopupMenuItem(
                  onTap: () {
                    _controller.future.then((value) {
                      DefaultAssetBundle.of(context)
                          .loadString('assets/map_theme/dark_theme.json')
                          .then((string) {
                        value.setMapStyle(string);
                      });
                    });
                  },
                  child: const Text('Dark'),
                ),
                PopupMenuItem(
                  onTap: () {
                    _controller.future.then((value) {
                      DefaultAssetBundle.of(context)
                          .loadString('assets/map_theme/aubergine_theme.json')
                          .then((string) {
                        value.setMapStyle(string);
                      });
                    });
                  },
                  child: const Text('Aubergine'),
                ),
                PopupMenuItem(
                  onTap: () {
                    _controller.future.then((value) {
                      DefaultAssetBundle.of(context)
                          .loadString('assets/map_theme/standard_theme.json')
                          .then((string) {
                        value.setMapStyle(string);
                      });
                    });
                  },
                  child: const Text('Standard'),
                ),
              ],
            ),
          ],
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text("Style Google Map",
              style: TextStyle(color: Colors.white))),
      body: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            controller.setMapStyle(mapTheme);
          }),
    );
  }
}
