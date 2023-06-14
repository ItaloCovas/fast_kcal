import 'package:fast_kcal/models/workout.dart';
import 'package:fast_kcal/utils/snackbar.dart';
import 'package:flutter/material.dart';

import '../controllers/login_controller.dart';
import '../controllers/workout_controller.dart';
import '../models/exercise.dart';
import '../widgets/drawer.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

List<String> activityLevelList = <String>[
  'Sedentário(a)',
  'Pouca atividade',
  'Atividade moderada',
  'Atividade intensa',
  'Atividade muito intensa'
];

class _WorkoutPageState extends State<WorkoutPage> {
  final _formKey = GlobalKey<FormState>();

  String activityDropdownValue = activityLevelList.first;

  void manageWorkouts(String activityLevel, String type) {
    if (_formKey.currentState!.validate()) {
      String workoutType = '';
      late List<Exercise> finalList;

      switch (activityLevel) {
        case 'Sedentário(a)':
          workoutType = 'Iniciante';
        case 'Pouca atividade':
          workoutType = 'Iniciante';
        case 'Atividade moderada':
          workoutType = 'Intermediário';
        case 'Atividade intensa':
          workoutType = 'Avançado';
        case 'Atividade muito intensa':
          workoutType = 'Avançado';
      }

      List<Exercise> beginnersExercises = [
        Exercise('Agachamento livre', 10, 3),
        Exercise('Supino reto', 10, 3),
        Exercise('Remada com halteres', 10, 3),
        Exercise('Desenvolvimento militar', 10, 3),
        Exercise('Levantamento terra', 10, 3),
        Exercise('Abdominal crunch', 15, 3),
        Exercise('Flexão de braço', 10, 3),
      ];

      List<Exercise> intermediateExercises = [
        Exercise('Agachamento frontal', 8, 4),
        Exercise('Supino inclinado com halteres', 8, 4),
        Exercise('Remada curvada', 8, 4),
        Exercise('Desenvolvimento com barra', 8, 4),
        Exercise('Levantamento terra sumô', 8, 4),
        Exercise('Prancha', 30, 3),
        Exercise('Rosca direta', 10, 3),
      ];

      List<Exercise> advancedExercises = [
        Exercise('Agachamento com salto', 6, 5),
        Exercise('Supino inclinado com barra', 6, 5),
        Exercise('Remada unilateral com halteres', 6, 5),
        Exercise('Desenvolvimento com halteres', 6, 5),
        Exercise('Levantamento terra convencional', 6, 5),
        Exercise('Prancha com elevação de pernas', 12, 4),
        Exercise('Curl com barra', 8, 4),
      ];

      switch (workoutType) {
        case 'Iniciante':
          finalList = beginnersExercises;
        case 'Intermediário':
          finalList = intermediateExercises;
        case 'Avançado':
          finalList = advancedExercises;
      }

      Workout finalWorkout = Workout(LoginController().getUserId(), finalList);
      if (type == 'create') {
        setState(() {
          WorkoutController().createWorkout(context, finalWorkout);
        });
      } else if (type == 'update') {
        setState(() {
          WorkoutController().updateWorkout(context, finalWorkout);
        });
      }
    }

    success(context, 'Treino editado com sucesso!');
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Text('Informe seu nível de atividade física',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.fade),
              ),
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.06,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffFFA123))),
                onPressed: () {
                  manageWorkouts(activityDropdownValue, 'create');
                  Navigator.of(context).pop();
                },
                child: const Text('Criar treino'),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Text('Informe seu nível de atividade física',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.fade),
              ),
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.06,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffFFA123))),
                onPressed: () {
                  manageWorkouts(activityDropdownValue, 'update');
                  Navigator.of(context).pop();
                },
                child: const Text('Editar treino'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
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
                  const Text('MEU TREINO:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(
                    height: 30,
                  ),
                  FutureBuilder<List<Workout>>(
                      future: WorkoutController().listWorkouts(context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.none ||
                            snapshot.connectionState ==
                                ConnectionState.waiting ||
                            snapshot.data!.isEmpty) {
                          return Center(
                            child: Column(
                              children: [
                                const Text(
                                  'Você ainda não possui treinos.',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Comece agora!',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_sharp,
                                      color: Colors.black),
                                  onPressed: () => _showDialog(),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Editar treino',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black38,
                                              fontSize: 16)),
                                      IconButton(
                                        icon: const Icon(Icons.edit,
                                            color: Colors.black),
                                        onPressed: () => _showEditDialog(),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        Workout workout = snapshot.data![index];

                                        List<Widget> exerciseWidgets = workout
                                            .exerciseList
                                            .map((exercise) {
                                          return Column(
                                            children: [
                                              Text(exercise.exercise,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                  '${exercise.repetitions.toString()} repetições'),
                                              Text(
                                                  '${exercise.series.toString()} séries'),
                                              const SizedBox(height: 40)
                                            ],
                                          );
                                        }).toList();

                                        return Column(
                                          children: exerciseWidgets,
                                        );
                                      }),
                                ),
                              ],
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
