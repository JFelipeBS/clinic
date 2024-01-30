import 'dart:io';

import 'package:clinicprofissional/src/model/profissional.dart';
import 'package:clinicprofissional/src/views/screens_clinic/agend/agend_page.dart';
import 'package:flutter/material.dart';

class ProfissionalScredule extends StatelessWidget {
  final String navigator;
  final Profissional prof;
  final String? image;
  final bool tipo;

  const ProfissionalScredule(
      {super.key,
      required this.navigator,
      this.image,
      this.tipo = true,
      required this.prof});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (navigator == '/AgendPage') {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AgendPage(prof: prof),
              ));
        }
        Navigator.pushNamed(context, navigator);
      },
      child: Container(
        width: double.maxFinite,
        height: 105,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue[900],
        ),
        child: Center(
          child: ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(File(prof.image!)),
              ),
              title: Text(
                prof.name,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                prof.especialidade,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              trailing: tipo
                  ? const Icon(
                      Icons.arrow_right_rounded,
                      color: Colors.white,
                      size: 30,
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.update,
                            color: Colors.green,
                            size: 30,
                          ),
                        ),
                      ],
                    )),
        ),
      ),
    );
  }
}
