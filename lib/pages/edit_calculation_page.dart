import 'package:fast_kcal/controllers/login_controller.dart';
import 'package:fast_kcal/models/calculation.dart';
import 'package:fast_kcal/pages/calculations_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controllers/calculation_controller.dart';

class EditCalculationPage extends StatefulWidget {
  final Calculation calculation;
  const EditCalculationPage({super.key, required this.calculation});

  @override
  State<EditCalculationPage> createState() => _EditCalculationPageState();
}

List<String> genderList = <String>['Masculino', 'Feminino'];
List<String> activityLevelList = <String>[
  'Sedentário(a)',
  'Pouca atividade',
  'Atividade moderada',
  'Atividade intensa',
  'Atividade muito intensa'
];

class _EditCalculationPageState extends State<EditCalculationPage> {
  late String genderDropdownValue;
  late String activityDropdownValue;

  final _formKey = GlobalKey<FormState>();

  late TextEditingController ageController = TextEditingController();
  late TextEditingController weightController = TextEditingController();
  late TextEditingController heightController = TextEditingController();

  var userId = LoginController().getUserId();

  @override
  void initState() {
    genderDropdownValue = widget.calculation.gender;
    activityDropdownValue = widget.calculation.activityLevel;
    ageController.text = widget.calculation.age.toString();
    weightController.text = widget.calculation.weight.toString();
    heightController.text = widget.calculation.height.toString();
    super.initState();
  }

  @override
  void dispose() {
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  void calculate(String gender, int age, double weight, double height,
      String activityLevel) {
    double activityLevelValue = 0;
    switch (activityLevel) {
      case 'Sedentário(a)':
        activityLevelValue = 1.2;
      case 'Pouca atividade':
        activityLevelValue = 1.375;
      case 'Atividade moderada':
        activityLevelValue = 1.55;
      case 'Atividade intensa':
        activityLevelValue = 1.725;
      case 'Atividade muito intensa':
        activityLevelValue = 1.9;
    }

    int tmb = 0;
    if (gender == 'Feminino') {
      tmb = (655 + (9.6 * weight) + (1.8 * height) - (4.7 * age)).round();
    } else {
      tmb = (66 + (13.7 * weight) + (5 * height) - (6.8 * age)).round();
    }

    int maintenance = (tmb * activityLevelValue).round();
    int loseWeight = maintenance - 450;
    int gainWeight = maintenance + 450;

    Calculation calculation = Calculation(
        LoginController().getUserId(),
        widget.calculation.uid,
        gender,
        age,
        weight,
        height,
        activityLevel,
        tmb,
        maintenance,
        loseWeight,
        gainWeight);

    CalculationController().updateCalculation(context, calculation);
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Text('Sucesso'),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            ],
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Atualização feita com sucesso!'),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Continuar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Meus cálculos'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CalculationsPage()));
              },
            ),
          ],
        );
      },
    );
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      final age = ageController.text;
      final weight = weightController.text;
      final height = heightController.text;

      calculate(genderDropdownValue, int.parse(age), double.parse(weight),
          double.parse(height), activityDropdownValue);

      _showDialog();
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
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const CalculationsPage())),
          ),
          iconTheme: const IconThemeData(color: Colors.black)),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Center(
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset('assets/img/logo.png'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Edite seu cálculo',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Seu sexo:',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: genderDropdownValue,
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              elevation: 16,
                              style: const TextStyle(color: Color(0xffFFA123)),
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffFFA123), width: 2),
                                ),
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  genderDropdownValue = value!;
                                });
                              },
                              items: genderList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Sua idade:',
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              keyboardType: TextInputType.number,
                              controller: ageController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Informe sua idade.';
                                }

                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: 'Digite sua idade...',
                                  constraints: BoxConstraints(maxHeight: 40),
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Seu peso:',
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d*')),
                              ],
                              controller: weightController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Informe seu peso.';
                                }

                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: 'Digite seu peso...',
                                  constraints: BoxConstraints(maxHeight: 40),
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Sua Altura:',
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d*')),
                              ],
                              controller: heightController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Informe sua altura.';
                                }

                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: 'Digite sua altura...',
                                  constraints: BoxConstraints(maxHeight: 40),
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Seu nível de atividade física:',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: activityDropdownValue,
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffFFA123), width: 2),
                                ),
                              ),
                              style: const TextStyle(color: Color(0xffFFA123)),
                              onChanged: (String? value) {
                                setState(() {
                                  activityDropdownValue = value as String;
                                });
                              },
                              items: activityLevelList
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
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
                                child: const Text('Calcular!'),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
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
