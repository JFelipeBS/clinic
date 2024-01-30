import 'package:clinicprofissional/src/model/scheduling.dart';

class Profissional {
  final String name;
  final String? image;
  final String register;
  final String especialidade;
  final List<Scheduling>? scheduling;

  Profissional({
    required this.name,
    required this.image,
    required this.register,
    required this.especialidade,
    List<Scheduling>? scheduling,
    // ignore: unnecessary_this
  }) : this.scheduling = scheduling ?? [];

  factory Profissional.fromMap(Map<String, dynamic> map) {
    List<dynamic> schedulingList = map['agendamentos'] ?? [];
    List<Scheduling> schedulings = schedulingList
        .map((schedulingMap) => Scheduling.fromMap(schedulingMap))
        .toList();
    return Profissional(
      name: map['name'],
      image: map['imageURL'],
      register: map['code'],
      especialidade: map['especialidade'],
      scheduling: schedulings,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageURL': image,
      'code': register,
      'especialidade': especialidade,
    };
  }
}
