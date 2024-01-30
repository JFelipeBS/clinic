import 'package:clinicprofissional/src/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void snabar(String msm) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msm)),
    );
  }

  void login(LoginController controller) async {
    await controller.selectedUser(userController.text);
  }

  void push(String page) {
    Navigator.pushNamedAndRemoveUntil(context, page, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginController>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Stack(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo/saude.png',
                          scale: 5.5,
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: userController,
                          validator: Validatorless.multiple([
                            Validatorless.required('Email obrigatorio'),
                            Validatorless.email('Não é um email valido')
                          ]),
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: 'Usuário',
                            prefixIcon: Icon(
                              Icons.person,
                              size: 30,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: passwordController,
                          validator: Validatorless.multiple([
                            Validatorless.required('Senha obrigatorio'),
                          ]),
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Senha',
                            prefixIcon: Icon(
                              Icons.lock_rounded,
                              size: 30,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Esqueceu a senha?',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 28),
                        ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await controller
                                  .selectedUser(userController.text);

                              if (controller.cargo != null) {
                                if (controller.cargo == false) {
                                  if (passwordController.text ==
                                      controller.userPatient!.password) {
                                    push('/homePatientPage');
                                  } else {
                                    controller.progress = false;
                                    snabar('Senha errada');
                                  }
                                } else {
                                  if (controller.cargo == true) {
                                    if (passwordController.text ==
                                        controller.userClinic!.password) {
                                      push('/ClinicPage');
                                    } else {
                                      controller.progress = false;
                                      snabar('Senha errada');
                                    }
                                  }
                                }
                              } else {
                                controller.progress = false;
                                snabar('Esse usuario nao existe');
                              }
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Entrar',
                                style: TextStyle(fontSize: 16),
                              ),
                              controller.progress
                                  ? const SizedBox(width: 25)
                                  : const SizedBox(),
                              controller.progress
                                  ? const SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        'Criar conta',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
