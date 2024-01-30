import 'package:flutter/material.dart';

class RegisterSelectPage extends StatefulWidget {
  const RegisterSelectPage({super.key});

  @override
  State<RegisterSelectPage> createState() => _RegisterSelectPageState();
}

class _RegisterSelectPageState extends State<RegisterSelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text(
          'Cadastrar-se como',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, '/registerPatient'),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  color: Colors.blue[300],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/register/paciente.png',
                          scale: 5,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Paciente',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, '/registerClinic'),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  color: Colors.blue[300],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/register/hospital.png',
                          scale: 5,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Clínica',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
