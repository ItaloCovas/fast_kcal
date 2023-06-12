import 'package:fast_kcal/models/calculation.dart';
import 'package:flutter/material.dart';

import '../controllers/login_controller.dart';

class CalculationDetailsPage extends StatefulWidget {
  final Calculation calculation;
  const CalculationDetailsPage({super.key, required this.calculation});

  @override
  State<CalculationDetailsPage> createState() => _CalculationDetailsPageState();
}

class _CalculationDetailsPageState extends State<CalculationDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: constraints.maxWidth * 0.8,
                    child: Center(
                      child: FutureBuilder<String>(
                          future: LoginController().loggedUser(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Column(
                                children: [
                                  const Icon(
                                    Icons.fitness_center_rounded,
                                    size: 70,
                                    color: Colors.orange,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text('${snapshot.data}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20))
                                ],
                              );
                            }

                            return const Text(
                              'Nome inválido',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            );
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.8,
                    child: Text(widget.calculation.gender),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.8,
                    child: Text(widget.calculation.age.toString()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.8,
                    child: Text(widget.calculation.activityLevel),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.8,
                    child: RichText(
                      text: TextSpan(
                        text: 'Seu metabolismo basal é de ',
                        style: const TextStyle(
                          fontSize: 16, // tamanho da fonte
                          color: Colors.black, // cor do texto
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '${widget.calculation.tmb} calorias',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold, // negrito
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.8,
                    child: RichText(
                      text: TextSpan(
                        text:
                            'Para manter o seu peso você precisa consumir em média ',
                        style: const TextStyle(
                          fontSize: 16, // tamanho da fonte
                          color: Colors.black, // cor do texto
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                '${widget.calculation.maintenanceCalories} calorias',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold, // negrito
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.8,
                    child: RichText(
                      text: TextSpan(
                        text:
                            'Para perder peso você precisa consumir em média ',
                        style: const TextStyle(
                          fontSize: 16, // tamanho da fonte
                          color: Colors.black, // cor do texto
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                '${widget.calculation.loseWeightCalories} calorias',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold, // negrito
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.8,
                    child: RichText(
                      text: TextSpan(
                        text:
                            'Para ganhar peso você precisa consumir em média ',
                        style: const TextStyle(
                          fontSize: 16, // tamanho da fonte
                          color: Colors.black, // cor do texto
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                '${widget.calculation.gainWeightCalories} calorias',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold, // negrito
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
