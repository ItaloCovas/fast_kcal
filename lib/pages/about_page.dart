import 'package:flutter/material.dart';

import '../widgets/drawer.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Sobre o projeto',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/img/logo.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/img/avatar-italo.jpeg',
                            fit: BoxFit.fitWidth,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: constraints.maxWidth * 0.8,
                      child: const Column(
                        children: [
                          Text(
                              'O app FastKcal foi desenvolvido para ser uma calculadora de calorias.',
                              textAlign: TextAlign.justify),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'A partir de dados informados pelo usuário (idade, peso, altura, etc.), é calculado a TAXA DE METABOLISMO BASAL da pessoa e também dicas para manter, aumentar ou diminuir o peso.',
                              textAlign: TextAlign.justify),
                          SizedBox(
                            height: 60,
                          ),
                          Text('Criado por Ítalo Covas',
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
