import 'dart:async';

import 'package:clinicprofissional/src/model/clinic.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLocationController extends ChangeNotifier {
  late LatLng position = const LatLng(37.42796133580664, -122.085749655962);
  late GoogleMapController _controller;
  final dio = Dio();

  void onMapCreate(GoogleMapController gmc) async {
    _controller = gmc;
    getPosition();
    notifyListeners();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnable;
    LocationPermission permission;

    serviceEnable = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnable) {
      return Future.error('Serviço de localização desligado');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permição de localização Negada');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Serviço de localização negado permanentemente, va em configuraçoes para abilitar');
    }

    return await Geolocator.getCurrentPosition();
  }

  void getPosition() async {
    try {
      final positionCurrent = await _determinePosition();
      _controller.animateCamera(CameraUpdate.newLatLng(
          LatLng(positionCurrent.latitude, positionCurrent.longitude)));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<Marker> maker(Clinic clinic) async {
    final response = await dio.get(
        'https://maps.googleapis.com/maps/api/geocode/json?address=${clinic.address},RN&key=AIzaSyB-mmEJz51meqmI-j2jm3GIvEDVthjSKxY');
    var data = response.data['results'][0]['geometry']['location'];

    final maker = Marker(
        markerId: MarkerId(clinic.uuid!),
        position: LatLng(data['lat'], data['lng']),
        infoWindow: InfoWindow(title: clinic.name));

    return maker;
  }
}
