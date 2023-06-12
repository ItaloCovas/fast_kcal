class Calculation {
  final String userId;
  final String uid;
  final String gender;
  final int age;
  final double weight;
  final double height;
  final String activityLevel;
  final int tmb;
  final int maintenanceCalories;
  final int loseWeightCalories;
  final int gainWeightCalories;

  Calculation(
      this.userId,
      this.uid,
      this.gender,
      this.age,
      this.weight,
      this.height,
      this.activityLevel,
      this.tmb,
      this.maintenanceCalories,
      this.loseWeightCalories,
      this.gainWeightCalories);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'uid': uid,
      'genero': gender,
      'idade': age,
      'peso': weight,
      'altura': height,
      'nivelAtividade': activityLevel,
      'tmb': tmb,
      'caloriasManutencao': maintenanceCalories,
      'caloriasPerda': loseWeightCalories,
      'caloriasGanho': gainWeightCalories
    };
  }

  factory Calculation.fromJson(Map<String, dynamic> json) {
    return Calculation(
      json['userId'],
      json['uid'],
      json['genero'],
      json['idade'],
      json['peso'],
      json['altura'],
      json['nivelAtividade'],
      json['tmb'],
      json['caloriasManutencao'],
      json['caloriasPerda'],
      json['caloriasGanho'],
    );
  }
}
