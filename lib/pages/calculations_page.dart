import 'package:fast_kcal/controllers/login_controller.dart';
import 'package:fast_kcal/models/calculation.dart';
import 'package:fast_kcal/pages/calculation_details_page.dart';
import 'package:flutter/material.dart';

import '../controllers/calculation_controller.dart';
import 'edit_calculation_page.dart';

class CalculationsPage extends StatefulWidget {
  const CalculationsPage({super.key});

  @override
  State<CalculationsPage> createState() => _CalculationsPageState();
}

class _CalculationsPageState extends State<CalculationsPage> {
  void delete(id) {
    setState(() {
      CalculationController().deleteCalculation(context, id);
    });
  }

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
                  FutureBuilder<List<Calculation>>(
                      future: CalculationController().listCalculations(context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.none ||
                            snapshot.connectionState ==
                                ConnectionState.waiting ||
                            snapshot.data!.isEmpty) {
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
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                Calculation calculation = snapshot.data![index];
                                return SizedBox(
                                  width: constraints.maxWidth * 0.5,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    borderOnForeground: true,
                                    elevation: 8,
                                    child: ListTile(
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit,
                                                color: Colors.black),
                                            onPressed: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditCalculationPage(
                                                            calculation:
                                                                snapshot.data![
                                                                    index]))),
                                          ),
                                          const SizedBox(width: 8),
                                          IconButton(
                                            icon: const Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () => delete(
                                                snapshot.data![index].uid),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CalculationDetailsPage(
                                                    calculation:
                                                        snapshot.data![index]),
                                          ),
                                        );
                                      },
                                      title: FutureBuilder<String>(
                                          future:
                                              LoginController().loggedUser(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              return Text(
                                                  '${snapshot.data} - ${calculation.age} anos',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold));
                                            }

                                            return const Text(
                                              'Cálculo inválido',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            );
                                          }),
                                      subtitle: Text(
                                        snapshot.data![index].activityLevel,
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
