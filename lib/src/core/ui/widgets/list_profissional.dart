import 'dart:io';

import 'package:clinicprofissional/src/controller/controller_hours.dart';
import 'package:clinicprofissional/src/model/clinic.dart';
import 'package:clinicprofissional/src/model/profissional.dart';
import 'package:clinicprofissional/src/views/screens_patient/scredule/scredule_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListProfissionais extends StatelessWidget {
  final Clinic clinic;
  const ListProfissionais({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    final List<Profissional>? profissionais = clinic.profissional;
    List<Widget> listTiles = [];

    for (int index = 0; index < profissionais!.length; index++) {
      listTiles.add(
        Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: FileImage(File(profissionais[index].image!)),
            ),
            title: Text(
              profissionais[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              profissionais[index].especialidade,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.arrow_right),
            tileColor: Colors.white,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScredulePage(
                        uuid: clinic.uuid, profissional: profissionais[index]),
                  )).then((value) {
                final h = Provider.of<ControllerHours>(context, listen: false);
                h.hourSelected = null;
              });
            },
          ),
        ),
      );
    }
    return Column(children: listTiles);
  }
}
