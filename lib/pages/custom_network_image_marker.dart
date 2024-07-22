import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomNetworkImageMarker extends StatefulWidget {
  const CustomNetworkImageMarker({super.key});

  @override
  State<CustomNetworkImageMarker> createState() =>
      _CustomNetworkImageMarkerState();
}

class _CustomNetworkImageMarkerState extends State<CustomNetworkImageMarker> {
  final Completer<GoogleMapController> _controller = Completer();
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(34.0150, 71.5249),
    zoom: 14,
  );
  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latlng = const [
    LatLng(34.002870, 71.542794),
    LatLng(33.998720, 71.538373),
    LatLng(34.002497, 71.556162),
  ];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < _latlng.length; i++) {
      Uint8List? image = await loadNetworkImageO(
          'https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp');
      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
          image!.buffer.asUint8List(),
          targetHeight: 100,
          targetWidth: 100);
      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData =
          await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();
      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
            // ignore: deprecated_member_use
            icon: BitmapDescriptor.fromBytes(resizedImageMarker),
            position: _latlng[i],
            infoWindow: InfoWindow(snippet: 'Title of Marker$i')),
      );
      setState(() {});
    }
  }

  Future<Uint8List?> loadNetworkImageO(String path) async {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image
        .resolve(
          const ImageConfiguration(),
        )
        .addListener(
          ImageStreamListener((info, _) => completer.complete(info)),
        );
    final imageInfo = await completer.future;
    final bytedata =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return bytedata!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.blue,
            title:
                const Text("Polykone", style: TextStyle(color: Colors.white))),
        body: GoogleMap(
            initialCameraPosition: _kGooglePlex,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            }));
  }
}
