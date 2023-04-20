import 'package:fast_kcal/pages/login_page.dart';
import 'package:fast_kcal/pages/registration_page.dart';
import 'package:fast_kcal/widgets/greeting_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.7,
                      child: const GreetingWidget(),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.7,
                      child: const Text(
                        'Registre-se ou faça login para acessar seu contador de calorias.',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.7,
                  height: constraints.maxHeight * 0.3,
                  child: Image.asset('assets/img/logo.png'),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.8,
                      height: constraints.maxHeight * 0.05,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,  MaterialPageRoute(builder: (context) => const LoginPage()));
                        },
                        style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xffFFA123))),
                        child: const Text('Login'),
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.03,
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.8,
                      height: constraints.maxHeight * 0.05,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,  MaterialPageRoute(builder: (context) => const RegistrationPage()));
                        },
                        style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xffFF5E5B))),
                        child: const Text('Registrar-se'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
