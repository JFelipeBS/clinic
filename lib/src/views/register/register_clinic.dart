import 'dart:io';

import 'package:clinicprofissional/src/controller/controller_clinic.dart';
import 'package:clinicprofissional/src/model/clinic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validatorless/validatorless.dart';

class RegisterClinicPage extends StatefulWidget {
  const RegisterClinicPage({super.key});

  @override
  State<RegisterClinicPage> createState() => _RegisterClinicPageState();
}

class _RegisterClinicPageState extends State<RegisterClinicPage> {
  final name = TextEditingController();
  final cnpj = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  final password = TextEditingController();
  final comfirmPassword = TextEditingController();
  final _fomrkey = GlobalKey<FormState>();

  @override
  void dispose() {
    name.dispose();
    cnpj.dispose();
    email.dispose();
    address.dispose();
    password.dispose();
    comfirmPassword.dispose();
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
                  key: _fomrkey,
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
                                  image == null ? File("") : File(image!.path),
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
                        validator: Validatorless.multiple(
                          [
                            Validatorless.required('Nome é obrigatório'),
                          ],
                        ),
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Nome da clínica',
                          prefixIcon: Icon(
                            Icons.local_hospital,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: cnpj,
                        validator: Validatorless.multiple(
                          [
                            Validatorless.required('CNPJ é obrigatório'),
                          ],
                        ),
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'CNPJ da clínica',
                          prefixIcon: Icon(
                            Icons.medical_information_rounded,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: email,
                        validator: Validatorless.multiple(
                          [
                            Validatorless.required('Email é obrigatório'),
                          ],
                        ),
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'E-mail da clínica',
                          prefixIcon: Icon(
                            Icons.email_rounded,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: address,
                        validator: Validatorless.multiple(
                          [
                            Validatorless.required('Endereço é obrigatório'),
                          ],
                        ),
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        keyboardType: TextInputType.streetAddress,
                        decoration: const InputDecoration(
                          hintText: 'Edereço: Cidade, Bairro, Nº',
                          prefixIcon: Icon(
                            Icons.maps_home_work_rounded,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: password,
                        validator: Validatorless.multiple(
                          [
                            Validatorless.required('Senha é obrigatório'),
                          ],
                        ),
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Senha',
                          prefixIcon: Icon(
                            Icons.lock,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: comfirmPassword,
                        validator: Validatorless.multiple(
                          [
                            Validatorless.required('Senha é obrigatório'),
                          ],
                        ),
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Confirme senha',
                          prefixIcon: Icon(
                            Icons.lock,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          if (_fomrkey.currentState!.validate()) {
                            if (password.text == comfirmPassword.text) {
                              Clinic clinic = Clinic(
                                uuid: '',
                                image: image!.path,
                                name: name.text,
                                cnpj: cnpj.text,
                                address: address.text,
                                cargo: true,
                                email: email.text,
                                password: password.text,
                              );

                              ControllerClinic controller = ControllerClinic();
                              controller.save(clinic.toMap());

                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/login', (route) => false);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Clinica Cadastrada'),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Senhas diferentes'),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
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
    );
  }
}
