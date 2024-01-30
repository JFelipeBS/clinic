import 'package:clinicprofissional/src/controller/controller_hours.dart';
import 'package:clinicprofissional/src/controller/controller_scredule.dart';
import 'package:clinicprofissional/src/core/ui/widgets/time_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HoursPane extends StatefulWidget {
  final double start;
  final double end;
  final List<double>? enableHours;

  const HoursPane({
    super.key,
    required this.start,
    required this.end,
    this.enableHours,
  });

  @override
  State<HoursPane> createState() => _HoursPaneState();
}

class _HoursPaneState extends State<HoursPane> {
  @override
  Widget build(BuildContext context) {
    final controllerSchedule = Provider.of<ControllerScredule>(context);

    return Column(
      children: [
        const Text(
          'Horários de atendimento',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 25),
        Consumer<ControllerHours>(
          builder: (context, controller, child) {
            controllerSchedule.selectdHours = controller.hourSelected;
            return Wrap(
              spacing: 8,
              runSpacing: 16,
              children: [
                for (double i = widget.start; i <= widget.end; i++)
                  TimeButton(
                    label: '${i.toInt().toString().padLeft(2, '0')}:00',
                    enableHours: widget.enableHours,
                    labelDouble: i,
                    hoursSelected: controller.hourSelected,
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
