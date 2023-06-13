import 'package:fast_kcal/pages/login_page.dart';
import 'package:flutter/material.dart';

class SuccessPage extends StatefulWidget {
  final String type;

  const SuccessPage({super.key, required this.type});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String message(String type) {
      switch (widget.type) {
        case 'email':
          return 'E-mail enviado com sucesso!';
        case 'registration':
          return 'Usuário registrado com sucesso!';
      }

      return '';
    }

    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Center(
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.asset('assets/img/check.png'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(message(widget.type),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
