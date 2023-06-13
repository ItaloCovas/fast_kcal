import 'package:fast_kcal/pages/main_page.dart';
import 'package:flutter/material.dart';

import '../controllers/login_controller.dart';
import '../pages/about_page.dart';
import '../pages/calculations_page.dart';
import '../pages/home_page.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Alterar meu nome',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 30,
              )
            ],
          ),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe seu nome.';
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Digite seu novo nome...',
                            constraints: BoxConstraints(maxHeight: 40),
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Salvar',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String newName = nameController.text;
                  setState(() {
                    LoginController().changeUsername(context, newName);
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 100,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xffFFA123),
              ),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder<String>(
                      future: LoginController().loggedUser(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Row(
                            children: [
                              const Text('Bem-vindo, '),
                              Text('${snapshot.data}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))
                            ],
                          );
                        }

                        return const Text(
                          'Bem-vindo, usuário',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        );
                      }),
                  IconButton(
                    icon: const Icon(Icons.logout_rounded, color: Colors.black),
                    onPressed: () {
                      LoginController().logout();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    },
                  ),
                ],
              )),
            ),
          ),
          ListTile(
            title: const Text('Calcular'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MainPage()));
            },
          ),
          ListTile(
            title: const Text('Sobre'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutPage()));
            },
          ),
          ListTile(
            title: const Text('Seus cálculos'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CalculationsPage()));
            },
          ),
          ListTile(
            title: const Text('Alterar meu nome'),
            onTap: () {
              _showDialog();
            },
          ),
        ],
      ),
    );
  }
}
