import 'package:fast_kcal/pages/success_page.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  bool isEmailValid = false;
  bool isPasswordRepeatitionValid = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  void validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    setState(() {
      isEmailValid = emailRegex.hasMatch(email);
    });
  }

  void validatePasswordRepeat(String password) {
    final passwordControllerText = passwordController.text;
    if(password == passwordControllerText) {
      setState(() {
        isPasswordRepeatitionValid = true;
      });
    }
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;
      final name = nameController.text;
      final repeat = repeatPasswordController.text;

      print('Data: $email, $name, $password, $repeat');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>  const SuccessPage(type: 'registration')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: constraints.maxWidth,
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset('assets/img/logo.png'),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('E-mail:',
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Informe seu e-mail.';
                                } else if (!isEmailValid) {
                                  return 'Informe um e-mail válido.';
                                }
                                return null;
                              },
                              onChanged: validateEmail,
                              decoration: const InputDecoration(
                                  helperText: " ",
                                  hintText: 'exemplo@exemplo.com',
                                  constraints: BoxConstraints(maxHeight: 40),
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: constraints.maxWidth * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Nome de usuário:',
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Informe seu nome de usuário.';
                                } else if (value.length < 6) {
                                  return 'Nome precisa ter no mínimo 6 caracteres';
                                } else if (value.length > 30) {
                                  return 'Nome precisa ter no máximo 30 caracteres';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  helperText: " ",
                                  hintText: 'Digite seu nome de usuário...',
                                  constraints: BoxConstraints(maxHeight: 40),
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: constraints.maxWidth * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Senha:',
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Informe sua senha.';
                                } else if (value.length < 8) {
                                  return 'Sua senha deve ter no mínimo 8 caracteres.';
                                }

                                return null;
                              },
                              decoration: const InputDecoration(
                                  helperText: " ",
                                  constraints: BoxConstraints(maxHeight: 40),
                                  hintText: 'Digite sua senha...',
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: constraints.maxWidth * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Confirmação de senha:',
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: repeatPasswordController,
                              validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Informe sua senha.';
                              } else if (value.length < 8) {
                                return 'Sua senha deve ter no mínimo 8 caracteres.';
                              } else if (!isPasswordRepeatitionValid) {
                                return 'As senhas devem ser iguais.';
                              }

                              return null;
                            },
                            onChanged: validatePasswordRepeat,
                              decoration: const InputDecoration(
                                  helperText: " ",
                                  hintText: 'Repita sua senha...',
                                  constraints: BoxConstraints(maxHeight: 40),
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: constraints.maxWidth * 0.8,
                        height: constraints.maxHeight * 0.06,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xffFF5E5B))),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              submitForm();
                            }
                          },
                          child: const Text('Registrar-se'),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
