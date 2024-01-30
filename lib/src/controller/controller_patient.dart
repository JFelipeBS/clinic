import 'package:clinicprofissional/src/model/patient.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ControllerPatient extends ChangeNotifier {
  Dio dio = Dio();

  void save(Map<String, dynamic> patient) async {
    try {
      await dio.post('http://10.0.2.2:8081/api/paciente', data: patient);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<Patient?> getLogin(String login) async {
    try {
      final response =
          await dio.get('http://10.0.2.2:8081/api/paciente?login=$login');
      if (response.statusCode == 200) {
        return Patient.fromMap(response.data);
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}
