import 'dart:io';

import 'package:clinicprofissional/src/controller/controller_profissional.dart';
import 'package:clinicprofissional/src/controller/login_controller.dart';
import 'package:clinicprofissional/src/model/profissional.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class RegisterProfissionalPage extends StatefulWidget {
  const RegisterProfissionalPage({super.key});

  @override
  State<RegisterProfissionalPage> createState() =>
      _RegisterProfissionalPageState();
}

class _RegisterProfissionalPageState extends State<RegisterProfissionalPage> {
  final name = TextEditingController();
  final register = TextEditingController();
  final profession = TextEditingController();

  final fomrkey = GlobalKey<FormState>();

  @override
  void dispose() {
    name.dispose();
    register.dispose();
    super.dispose();
  }

  XFile? image;

  _selectedImage() async {
    final ImagePicker picker = ImagePicker();

    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        setState(() {
          image = file;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    key: fomrkey,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            _selectedImage();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: FileImage(
                                    image == null
                                        ? File("")
                                        : File(image!.path),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              height: 100,
                              width: 100,
                              child: image == null
                                  ? const Icon(
                                      Icons.image,
                                      size: 25,
                                    )
                                  : null),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: name,
                          validator: Validatorless.multiple([
                            Validatorless.required('Nome é obrigatório'),
                          ]),
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: 'Nome',
                            prefixIcon: Icon(
                              Icons.local_hospital,
                              size: 30,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: register,
                          validator: Validatorless.multiple([
                            Validatorless.required('Registro é obrigatório'),
                          ]),
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Registro',
                            prefixIcon: Icon(
                              Icons.medical_information_rounded,
                              size: 30,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: profession,
                          validator: Validatorless.multiple([
                            Validatorless.required('Profissão é obrigatório'),
                          ]),
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Profissão',
                            prefixIcon: Icon(
                              Icons.work_rounded,
                              size: 30,
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        ElevatedButton(
                          onPressed: () {
                            final controller = ControllerProfissional();

                            if (fomrkey.currentState!.validate()) {
                              final profissional = Profissional(
                                  image: image!.path,
                                  name: name.text,
                                  register: register.text,
                                  especialidade: profession.text);
                              controller.save(
                                  profissional.toMap(),
                                  Provider.of<LoginController>(context,
                                          listen: false)
                                      .userClinic!
                                      .cnpj);

                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Profissional Cadastrado'),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Erro ao cadastrar'),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'Cadastrar',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
