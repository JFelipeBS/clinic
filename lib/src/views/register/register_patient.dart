import 'dart:io';

import 'package:clinicprofissional/src/controller/controller_patient.dart';
import 'package:clinicprofissional/src/model/patient.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPatient extends StatefulWidget {
  const RegisterPatient({super.key});

  @override
  State<RegisterPatient> createState() => _RegisterPatientState();
}

class _RegisterPatientState extends State<RegisterPatient> {
  final name = TextEditingController();
  final cpf = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final comfirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    name.dispose();
    cpf.dispose();
    email.dispose();
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
                key: _formKey,
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
                      validator: Validatorless.multiple([
                        Validatorless.required('O nome é obrigatório'),
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
                      controller: cpf,
                      validator: Validatorless.multiple([
                        Validatorless.required('O cpf é obrigatorio'),
                        Validatorless.cpf('Esse cpf nao é valido')
                      ]),
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'CPF',
                        prefixIcon: Icon(
                          Icons.medical_information_rounded,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: email,
                      validator: Validatorless.multiple([
                        Validatorless.required('O email é obrigatório'),
                        Validatorless.email('Esse email nao é valido')
                      ]),
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'E-mail',
                        prefixIcon: Icon(
                          Icons.email_rounded,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: password,
                      validator: Validatorless.multiple([
                        Validatorless.required('A senha é obrigatorio'),
                      ]),
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
                      validator: Validatorless.multiple([
                        Validatorless.required('A senha é obrigatorio'),
                      ]),
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
                        if (_formKey.currentState!.validate()) {
                          if (password.text == comfirmPassword.text) {
                            Patient patient = Patient(
                              uuid: '',
                              image: image!.path,
                              name: name.text,
                              cpf: cpf.text,
                              email: email.text,
                              password: password.text,
                              cargo: false,
                            );

                            ControllerPatient controller = ControllerPatient();
                            controller.save(patient.toMap());

                            Navigator.pushNamedAndRemoveUntil(
                                context, '/login', (route) => false);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Paciente Cadastrado'),
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
      )),
    );
  }
}
