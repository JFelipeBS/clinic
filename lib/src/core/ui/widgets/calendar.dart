import 'package:clinicprofissional/src/controller/controller_scredule.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime? selectedDay;
  @override
  Widget build(BuildContext context) {
    final controllerSchedule = Provider.of<ControllerScredule>(context);
    if (selectedDay != null) {
      if (selectedDay != controllerSchedule.selectedDay) {
        controllerSchedule.selectedDay = selectedDay!;
        controllerSchedule.getList();
      }
    }
    return Column(
      children: [
        const Text(
          'Dia do atendimento',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TableCalendar(
          selectedDayPredicate: (day) {
            return isSameDay(selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              this.selectedDay = selectedDay;
            });
          },
          headerStyle: const HeaderStyle(titleCentered: true),
          availableGestures: AvailableGestures.none,
          focusedDay: DateTime.now(),
          firstDay: DateTime.now(),
          rangeStartDay: DateTime.now(),
          lastDay: DateTime.now().add(const Duration(days: 365) * 10),
          calendarFormat: CalendarFormat.month,
          locale: 'pt-BR',
          availableCalendarFormats: const {CalendarFormat.month: 'Month'},
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: Colors.blue[900],
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: Colors.blue[900]!.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
