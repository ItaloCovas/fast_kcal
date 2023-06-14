class Exercise {
  final String exercise;
  final int series;
  final int repetitions;

  Exercise(this.exercise, this.repetitions, this.series);

  Map<String, dynamic> toJson() {
    return {
      'exercicio': exercise,
      'repeticoes': repetitions,
      'series': series,
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(json['exercicio'], json['repeticoes'], json['series']);
  }
}
