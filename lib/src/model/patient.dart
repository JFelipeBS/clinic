// ignore_for_file: unnecessary_this

import 'package:clinicprofissional/src/model/scheduling.dart';

class Patient {
  final String? uuid;
  final String? image;
  final String name;
  final String cpf;
  final String email;
  final String password;
  final bool cargo;
  final List<Scheduling>? scheduling;

  Patient({
    required this.uuid,
    required this.image,
    required this.name,
    required this.cpf,
    required this.email,
    required this.password,
    required this.cargo,
    List<Scheduling>? scheduling,
  }) : this.scheduling = scheduling ?? [];

  factory Patient.fromMap(Map<String, dynamic> map) {
    List<dynamic> schedulingList = map['agendamentos'] ?? [];
    List<Scheduling> schedulings = schedulingList
        .map((schedulingMap) => Scheduling.fromMap(schedulingMap))
        .toList();
    return Patient(
      uuid: map['uuid'],
      image: map['imageURL'],
      name: map['name'],
      cpf: map['cpf'],
      email: map['login'],
      password: map['password'],
      cargo: map['cargo'],
      scheduling: schedulings,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageURL': image,
      'cpf': cpf,
      'login': email,
      'password': password,
      'cargo': cargo,
    };
  }
}
