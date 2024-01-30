// ignore_for_file: unnecessary_this

import 'package:clinicprofissional/src/model/profissional.dart';
import 'package:clinicprofissional/src/model/scheduling.dart';

class Clinic {
  final String? uuid;
  final String? image;
  final String name;
  final String cnpj;
  final String address;
  final String email;
  final String password;
  final bool cargo;
  bool visible;

  final List<Profissional>? profissional;
  final List<Scheduling>? scheduling;

  Clinic({
    required this.uuid,
    required this.image,
    required this.name,
    required this.cnpj,
    required this.address,
    required this.email,
    required this.password,
    required this.cargo,
    this.visible = false,
    List<Profissional>? profissional,
    List<Scheduling>? scheduling,
  })  : this.profissional = profissional ?? [],
        this.scheduling = scheduling ?? [];

  factory Clinic.fromMap(Map<String, dynamic> map) {
    List<dynamic> profissionaisList = map['profissionais'] ?? [];
    List<Profissional> profissionais = profissionaisList
        .map((profissionalMap) => Profissional.fromMap(profissionalMap))
        .toList();

    List<dynamic> schedulingList = map['agendamentos'] ?? [];
    List<Scheduling> schedulings = schedulingList
        .map((schedulingMap) => Scheduling.fromMap(schedulingMap))
        .toList();

    return Clinic(
      uuid: map['uuid'],
      image: map['imageURL'],
      name: map['name'],
      cnpj: map['cnpj'],
      address: map['address'],
      cargo: map['cargo'],
      email: map['login'],
      password: map['password'],
      profissional: profissionais,
      scheduling: schedulings,
    );
  }

  static List<Clinic> fromMapList(List<dynamic> map) {
    List<dynamic> cliicList = map;
    List<Clinic> clinicas =
        cliicList.map((cliicaMap) => Clinic.fromMap(cliicaMap)).toList();

    return clinicas;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageURL': image,
      'cnpj': cnpj,
      'address': address,
      'cargo': cargo,
      'login': email,
      'password': password,
    };
  }
}
