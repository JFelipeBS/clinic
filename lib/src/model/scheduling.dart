class Scheduling {
  final String? uuid;
  final String appointmentDate;
  final double appointmentTime;
  final int sessionTime;

  Scheduling({
    required this.uuid,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.sessionTime,
  });

  factory Scheduling.fromMap(Map<String, dynamic> map) {
    return Scheduling(
      uuid: map['uuid'],
      appointmentDate: map['appointmentDate'],
      appointmentTime: map['appointmentTime'].toDouble(),
      sessionTime: map['sessionTime'],
    );
  }

  static List<double> fromMapList(List<dynamic> map) {
    List<dynamic> list = map;
    List<double> appointmentTimeList = list.map<double>((h) {
      return h["appointmentTime"].toDouble();
    }).toList();

    return appointmentTimeList;
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'appointmentDate': appointmentDate,
      'appointmentTime': appointmentTime,
      'sessionTime': sessionTime,
    };
  }
}
