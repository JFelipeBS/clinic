import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ControllerProfissional {
  Dio dio = Dio();

  void save(Map<String, dynamic> profissional, String cnpj) async {
    try {
      await dio.post('http://10.0.2.2:8081/api/clinica/$cnpj/profissional',
          data: profissional);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
