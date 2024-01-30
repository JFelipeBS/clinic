import 'package:clinicprofissional/src/controller/map_location_controller.dart';
import 'package:clinicprofissional/src/model/clinic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class GoogleMapsWidget extends StatefulWidget {
  final Clinic clinic;
  const GoogleMapsWidget({super.key, required this.clinic});

  @override
  State<GoogleMapsWidget> createState() => _GoogleMapsWidgetState();
}

class _GoogleMapsWidgetState extends State<GoogleMapsWidget> {
  Set<Marker> markers = {};
  late MapLocationController controller;

  void setMark() async {
    final marker = await controller.maker(widget.clinic);

    setState(() {
      markers.add(marker);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    markers.clear();
    super.dispose();
  }

  @override
  void initState() {
    controller = MapLocationController();
    setMark();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.blue[900],
      child: GoogleMap(
        markers: markers,
        mapType: MapType.normal,
        zoomControlsEnabled: true,
        initialCameraPosition: CameraPosition(
          target: controller.position,
          zoom: 11,
        ),
        onMapCreated: controller.onMapCreate,
        myLocationEnabled: true,
      ),
    );
  }
}
