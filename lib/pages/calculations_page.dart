import 'package:fast_kcal/models/calculation.dart';
import 'package:fast_kcal/pages/calculation_details_page.dart';
import 'package:flutter/material.dart';

class CalculationsPage extends StatefulWidget {
  final List<Calculation> calculations;
  const CalculationsPage({super.key, required this.calculations});

  @override
  State<CalculationsPage> createState() => _CalculationsPageState();
}

class _CalculationsPageState extends State<CalculationsPage> {
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
                    width: constraints.maxWidth * 0.7,
                    height: constraints.maxHeight * 0.4,
                    child: Image.asset('assets/img/logo.png'),
                  ),
                  Builder(builder: (context) {
                    if (widget.calculations.isEmpty) {
                      return const Center(
                        child: Text(
                          'Você ainda não possui cálculos.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: widget.calculations.length,
                          itemBuilder: (context, index) {
                            Calculation calculation =
                                widget.calculations[index];
                            return SizedBox(
                              width: constraints.maxWidth * 0.5,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                borderOnForeground: true,
                                elevation: 5,
                                child: ListTile(
                                  onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CalculationDetailsPage(
                                          calculation: widget.calculations[index]),
                                    ),
                                  );
                                },
                                  title: Text(
                                      'Nome da pessoa - ${calculation.age} anos',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Text(
                                    calculation.activityLevel,
                                    style: const TextStyle(
                                        color: Color(0xffFFA123)),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
