import 'package:clinicprofissional/src/controller/login_controller.dart';
import 'package:clinicprofissional/src/core/ui/widgets/profissionais_scredule.dart';
import 'package:clinicprofissional/src/model/profissional.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeClinicPage extends StatefulWidget {
  const HomeClinicPage({super.key});

  @override
  State<HomeClinicPage> createState() => _HomeClinicPageState();
}

class _HomeClinicPageState extends State<HomeClinicPage> {
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
          "Profissionais",
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
        child: Center(
          child: Consumer<LoginController>(
            builder: (context, controller, child) {
              return FutureBuilder(
                future: controller.updateList(),
                builder: (context, snapshot) {
                  List<Profissional>? prof = snapshot.data;
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
                      return prof!.isNotEmpty
                          ? ListView.builder(
                              itemCount: prof.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ProfissionalScredule(
                                    navigator: '/AgendPage',
                                    prof: prof[index],
                                  ),
                                );
                              },
                            )
                          : const Text('Não há profissionais cadastrados');
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
