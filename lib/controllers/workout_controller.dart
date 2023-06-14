import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/workout.dart';
import '../utils/snackbar.dart';
import 'login_controller.dart';

class WorkoutController {
  createWorkout(context, Workout workout) {
    FirebaseFirestore.instance
        .collection('treinos')
        .doc(workout.uid)
        .set(workout.toJson())
        .then((value) {
      Navigator.of(context).pop();
    }).catchError((e) {
      error(context, 'Erro na criação: ${e.code.toString()}');
    });
  }

  updateWorkout(context, Workout workout) {
    FirebaseFirestore.instance
        .collection('treinos')
        .doc(workout.uid)
        .update(workout.toJson())
        .catchError(
            (e) => error(context, 'Erro na atualização: ${e.code.toString()}'));
  }

  Future<List<Workout>> listWorkouts(context) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('treinos')
          .where('uid', isEqualTo: LoginController().getUserId())
          .get();
      List<Workout> workouts = [];
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        Workout workout = Workout.fromJson(data);
        workouts.add(workout);
      }
      return workouts;
    } catch (e) {
      error(context, 'Erro no retorno do treino, tente novamente.');
      return [];
    }
  }
}
