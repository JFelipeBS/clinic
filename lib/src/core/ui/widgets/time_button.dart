import 'package:clinicprofissional/src/controller/controller_hours.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeButton extends StatefulWidget {
  final String label;
  final double labelDouble;
  final List<double>? enableHours;
  final double? hoursSelected;
  const TimeButton({
    super.key,
    required this.label,
    this.enableHours,
    required this.labelDouble,
    this.hoursSelected,
  });

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    final textColor = selected ? Colors.white : Colors.black;
    var buttonColor = selected ? Colors.blue : Colors.white;
    Color boderColor = Colors.blue;

    final disableHours = widget.enableHours!.contains(widget.labelDouble);

    if (disableHours) {
      buttonColor = Colors.grey[400]!;
      boderColor = Colors.grey[400]!;
    }
    final controller = Provider.of<ControllerHours>(context, listen: false);

    if (controller.hourSelected != null) {
      if (controller.hourSelected == widget.labelDouble) {
        selected = true;
      } else {
        selected = false;
      }
    }

    return InkWell(
      onTap: disableHours
          ? null
          : () {
              controller.chandeHours(widget.labelDouble);
            },
      child: Container(
        height: 36,
        width: 64,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: boderColor),
        ),
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 12, color: textColor),
          ),
        ),
      ),
    );
  }
}
