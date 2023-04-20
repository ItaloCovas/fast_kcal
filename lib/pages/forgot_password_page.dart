import 'package:fast_kcal/pages/success_page.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool isEmailValid = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    setState(() {
      isEmailValid = emailRegex.hasMatch(email);
    });
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text;
      print('Email address: $email');
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SuccessPage(type: 'email')));
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
          return Center(
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
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
                    const SizedBox(height: 30.0),
                    SizedBox(
                      width: constraints.maxWidth * 0.8,
                      child: const Text(
                          'Esqueceu sua senha? Informe seu e-mail abaixo e enviaremos um código para recuperação!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 30.0),
                    SizedBox(
                      width: constraints.maxWidth * 0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'E-mail:',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10,),
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
                                hintText: 'exemplo@exemplo.com',
                                constraints: BoxConstraints(maxHeight: 40),
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
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
                                const Color(0xffFFA123))),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            submitForm();
                          }
                        },
                        child: const Text('Enviar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
