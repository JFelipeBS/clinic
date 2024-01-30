import 'package:clinicprofissional/src/model/scheduling.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentDs extends CalendarDataSource {
  final List<Scheduling> schedule;

  AppointmentDs(this.schedule);

  @override
  List<dynamic>? get appointments => schedule.map((sched) {
        final parts = sched.appointmentDate.split('-');
        final dateTime = DateTime(int.parse(parts[0]), int.parse(parts[1]),
            int.parse(parts[2]), sched.appointmentTime.toInt(), 0);

        return Appointment(
            startTime: dateTime,
            endTime: dateTime.add(
              const Duration(hours: 1),
            ),
            subject: 'Consulta');
      }).toList();
}
