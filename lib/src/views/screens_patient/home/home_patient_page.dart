import 'dart:io';

import 'package:clinicprofissional/src/controller/login_controller.dart';
import 'package:clinicprofissional/src/core/ui/widgets/google_maps_widget.dart';
import 'package:clinicprofissional/src/core/ui/widgets/list_profissional.dart';
import 'package:clinicprofissional/src/model/clinic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePatientPage extends StatefulWidget {
  const HomePatientPage({super.key});

  @override
  State<HomePatientPage> createState() => _HomePatientPageState();
}

bool isVisible = false;

class _HomePatientPageState extends State<HomePatientPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                controller.logout();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
              icon: const Icon(
                Icons.logout_rounded,
                color: Colors.red,
              ))
        ],
        title: const Text(
          "Clinicas Disponiveis",
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
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
        child: Consumer<LoginController>(
          builder: (context, controller, child) {
            return FutureBuilder(
              future: controller.listClinic(),
              builder: (context, snapshot) {
                List<Clinic>? clin = snapshot.data;
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Container();
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.active:
                    return Container();
                  case ConnectionState.done:
                    if (clin!.isNotEmpty) {
                      return SingleChildScrollView(
                        child: ExpansionPanelList.radio(
                          children: clin.map((clinic) {
                            return ExpansionPanelRadio(
                              backgroundColor: Colors.blue[900],
                              value: int.parse(clinic.cnpj),
                              canTapOnHeader: true,
                              headerBuilder: (context, isExpanded) {
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          FileImage(File(clinic.image!)),
                                    ),
                                    title: Text(
                                      clinic.name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              },
                              body: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 10),
                                    GoogleMapsWidget(
                                      clinic: clinic,
                                    ),
                                    const SizedBox(height: 20),
                                    const Text(
                                      'Profissionais',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(height: 20),
                                    ListProfissionais(
                                      clinic: clinic,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(), // Converta o Iterable em uma lista aqui
                        ),
                      );
                    } else {
                      const Center(
                        child: Text('Não há profissionais cadastrados'),
                      );
                    }
                }
                return Container();
              },
            );
          },
        ),
      ),
    );
  }
}
