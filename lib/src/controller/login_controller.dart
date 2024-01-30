import 'package:clinicprofissional/src/controller/controller_clinic.dart';
import 'package:clinicprofissional/src/controller/controller_patient.dart';
import 'package:clinicprofissional/src/model/clinic.dart';
import 'package:clinicprofissional/src/model/patient.dart';
import 'package:clinicprofissional/src/model/profissional.dart';
import 'package:flutter/foundation.dart';

class LoginController extends ChangeNotifier {
  bool? cargo;
  bool progress = false;
  ControllerPatient controllerPatient = ControllerPatient();
  ControllerClinic controllerClinic = ControllerClinic();

  Clinic? userClinic;
  Patient? userPatient;
  selectedUser(String login) async {
    progress = true;
    try {
      Patient? patient = await controllerPatient.getLogin(login);
      if (patient != null) {
        cargo = false;
        userPatient = patient;
        return;
      }

      Clinic? clinic = await controllerClinic.getLogin(login);
      if (clinic != null) {
        cargo = true;
        userClinic = clinic;
        return;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void logout() {
    userClinic = null;
    userPatient = null;
    cargo = null;
    progress = false;
  }

  Future<List<Profissional>?> updateList() async {
    Clinic? clinic = await controllerClinic.getCpj(userClinic!.cnpj);
    userClinic = clinic;

    if (userClinic != null) {
      return userClinic!.profissional;
    } else {
      return [];
    }
  }

  List<Clinic> clinicList = [];
  Future<List<Clinic>?> listClinic() async {
    clinicList = (await controllerClinic.getList())!;
    return clinicList;
  }
}
