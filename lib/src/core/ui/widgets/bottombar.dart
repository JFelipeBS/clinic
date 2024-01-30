import 'package:clinicprofissional/src/views/screens_clinic/home/home_clinic_page.dart';
import 'package:clinicprofissional/src/views/screens_clinic/profissional/profissional_page.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeClinicPage(),
    const ProfissionalPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedIconTheme: IconThemeData(color: Colors.blue[900]),
        selectedFontSize: 18,
        unselectedFontSize: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.house_rounded), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.work), label: 'Profissionais'),
        ],
      ),
    );
  }
}
