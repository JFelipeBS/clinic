import 'package:clinicprofissional/src/model/clinic.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ControllerClinic extends ChangeNotifier {
  Dio dio = Dio();

  void save(Map<String, dynamic> patient) async {
    try {
      await dio.post('http://10.0.2.2:8081/api/clinica', data: patient);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<Clinic?> getLogin(String login) async {
    try {
      final response =
          await dio.get('http://10.0.2.2:8081/api/clinica?login=$login');
      if (response.statusCode == 200) {
        return Clinic.fromMap(response.data);
      } else {
        return null; // Retorna null caso a clínica não seja encontrada
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null; // Retorna null em caso de erro na solicitação
    }
  }

  Future<Clinic?> getCpj(String cnpj) async {
    try {
      final response = await dio.get('http://10.0.2.2:8081/api/clinica/$cnpj');
      if (response.statusCode == 200) {
        return Clinic.fromMap(response.data);
      } else {
        return null; // Retorna null caso a clínica não seja encontrada
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null; // Retorna null em caso de erro na solicitação
    }
  }

  Future<List<Clinic>?> getList() async {
    try {
      final response = await dio.get('http://10.0.2.2:8081/api/clinica/list');
      if (response.statusCode == 200) {
        return Clinic.fromMapList(response.data);
      } else {
        return null; // Retorna null caso a clínica não seja encontrada
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null; // Retorna null em caso de erro na solicitação
    }
  }
}
