import 'package:clinicprofissional/src/core/ui/clinic_profissional_theme.dart';
import 'package:clinicprofissional/src/core/ui/widgets/bottombar.dart';
import 'package:clinicprofissional/src/views/login/login_page.dart';
import 'package:clinicprofissional/src/views/register/register_clinic.dart';
import 'package:clinicprofissional/src/views/register/register_patient.dart';
import 'package:clinicprofissional/src/views/register/regsiter_select.dart';
import 'package:clinicprofissional/src/views/screens_clinic/profissional/register_profissional_page.dart';
import 'package:clinicprofissional/src/views/screens_patient/home/home_patient_page.dart';
import 'package:clinicprofissional/src/views/splash/splash_page.dart';
import 'package:flutter/material.dart';

class ClinicProfissional extends StatelessWidget {
  const ClinicProfissional({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clinic',
      theme: CliniCProfissionalTheme.themeData,
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => const SplashPage(),
        '/login': (_) => const LoginPage(),
        '/home': (_) => const LoginPage(),
        '/register': (_) => const RegisterSelectPage(),
        '/registerPatient': (_) => const RegisterPatient(),
        '/registerClinic': (_) => const RegisterClinicPage(),
        '/homePatientPage': (_) => const HomePatientPage(),
        '/ClinicPage': (_) => const BottomBar(),
        '/registerProfissional': (_) => const RegisterProfissionalPage(),
      },
    );
  }
}
