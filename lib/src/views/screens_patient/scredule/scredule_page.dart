import 'package:clinicprofissional/src/controller/controller_hours.dart';
import 'package:clinicprofissional/src/controller/controller_scredule.dart';
import 'package:clinicprofissional/src/controller/login_controller.dart';
import 'package:clinicprofissional/src/core/ui/widgets/calendar.dart';
import 'package:clinicprofissional/src/core/ui/widgets/hours_pane.dart';
import 'package:clinicprofissional/src/model/profissional.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScredulePage extends StatefulWidget {
  final String? uuid;
  final Profissional profissional;

  const ScredulePage(
      {super.key, required this.uuid, required this.profissional});

  @override
  State<ScredulePage> createState() => _ScredulePageState();
}

class _ScredulePageState extends State<ScredulePage> {
  late ControllerScredule controller;
  @override
  void initState() {
    controller = Provider.of<ControllerScredule>(context, listen: false);
    controller.uuid = widget.uuid!;
    controller.register = widget.profissional;
    controller.getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controllerD = Provider.of<LoginController>(context, listen: false);
    final controllerL = Provider.of<LoginController>(context, listen: false);
    controller.uuid = widget.uuid!;
    controller.register = widget.profissional;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                controllerD.logout();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
              icon: const Icon(
                Icons.logout_rounded,
                color: Colors.red,
              ))
        ],
        title: Column(
          children: [
            const Text(
              "Agendameto",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
            Text(
              widget.profissional.name,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(right: 10, left: 10, bottom: 10, top: 10),
        child: SingleChildScrollView(
            child: Column(
          children: [
            const Calendar(),
            const SizedBox(height: 15),
            Consumer<ControllerScredule>(
              builder: (context, controller, child) {
                return HoursPane(
                  start: 7,
                  end: 17,
                  enableHours: controller.h,
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  if (controller.selectdHours == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Selecione um dia e um horário'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                    ));
                  } else {
                    controller.save(widget.uuid!, widget.profissional,
                        controllerL.userPatient!.cpf);
                    controller.selectdHours = null;
                    controller.getList();
                    controller.h = [];

                    final h =
                        Provider.of<ControllerHours>(context, listen: false);
                    h.hourSelected = null;
                    controller.selectdHours = null;
                    controller.selectedDay = DateTime.now();

                    Navigator.pop(context);
                  }
                },
                child: const Text('Agendar')),
          ],
        )),
      ),
    );
  }
}
