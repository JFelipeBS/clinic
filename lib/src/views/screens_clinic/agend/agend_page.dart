import 'package:clinicprofissional/src/model/profissional.dart';
import 'package:clinicprofissional/src/views/screens_clinic/agend/appointment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AgendPage extends StatefulWidget {
  final Profissional prof;
  const AgendPage({super.key, required this.prof});

  @override
  State<AgendPage> createState() => _AgendPageState();
}

class _AgendPageState extends State<AgendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Agenda",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
      ),
      body: SfCalendar(
        view: CalendarView.day,
        showNavigationArrow: true,
        todayHighlightColor: Colors.blue[900],
        showTodayButton: true,
        showDatePickerButton: true,
        dataSource: AppointmentDs(widget.prof.scheduling!),
        onTap: (calendarTapDetails) {
          // ignore: unnecessary_null_comparison
          if (calendarTapDetails != null &&
              calendarTapDetails.appointments!.isNotEmpty) {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                final dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
                return SizedBox(
                  height: 200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Clinete',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                            dateFormat.format(
                                calendarTapDetails.date ?? DateTime.now()),
                            style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
        appointmentBuilder: (context, calendarAppointmentDetails) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue[900],
                shape: BoxShape.rectangle),
            child: Center(
                child: Text(
              calendarAppointmentDetails.appointments.first.subject,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            )),
          );
        },
      ),
    );
  }
}
