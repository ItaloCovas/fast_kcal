import 'exercise.dart';

class Workout {
  final String uid;
  final List<Exercise> exerciseList;

  Workout(this.uid, this.exerciseList);

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'listaExercicios':
          exerciseList.map((exercise) => exercise.toJson()).toList(),
    };
  }

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      json['uid'],
      (json['listaExercicios'] as List<dynamic>)
          .map((exerciseJson) => Exercise.fromJson(exerciseJson))
          .toList(),
    );
  }
}
