import 'package:clinicprofissional/src/clinic_profissional.dart';
import 'package:clinicprofissional/src/controller/controller_hours.dart';
import 'package:clinicprofissional/src/controller/controller_scredule.dart';
import 'package:clinicprofissional/src/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  initializeDateFormatting();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoginController()),
      ChangeNotifierProvider(create: (_) => ControllerHours()),
      ChangeNotifierProvider(create: (_) => ControllerScredule()),
    ],
    child: const ClinicProfissional(),
  ));
}
