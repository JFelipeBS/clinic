import 'package:clinicprofissional/src/model/profissional.dart';
import 'package:clinicprofissional/src/model/scheduling.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ControllerScredule extends ChangeNotifier {
  Dio dio = Dio();
  DateTime selectedDay = DateTime.now();
  double? selectdHours;
  List<double> h = [];

  String uuid = '';
  Profissional? register;

  Future<void> getList() async {
    try {
      final response = await dio.get(
          'http://10.0.2.2:8081/api/clinica/$uuid/${register!.register}/agendamentos?dia=${selectedDay.toString().split(' ')[0]}');
      if (response.statusCode == 200) {
        h = Scheduling.fromMapList(response.data);
        notifyListeners();
      } else {
        h = [];
      }
    } catch (e) {
      h = [];
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void save(
    String uuid,
    Profissional profissional,
    String cpf,
  ) async {
    Scheduling scheduling = Scheduling(
      uuid: '',
      appointmentDate: selectedDay.toString().split(' ')[0],
      appointmentTime: selectdHours!,
      sessionTime: 1,
    );

    Map<String, dynamic> save = {
      "code": profissional.register,
      "cpf": cpf,
      "agendamento": scheduling.toMap(),
    };

    try {
      await dio.post('http://10.0.2.2:8081/api/clinica/$uuid/agendamentos',
          data: save);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
