
class MOUser {
  String uid;
  int age, schoolType, gender, grade, session;
  bool hasPerformanceData;

  MOUser(this.age, this.schoolType, this.gender, this.grade,
      this.hasPerformanceData);

  Map<String, dynamic> toJsonPrediction() => {
        'edad': age,
        'tipoEscuela': schoolType,
        'genero': gender,
        'grado': grade,
      };

  Map<String, dynamic> toJson() => {
        'age': age,
        'schoolType': schoolType,
        'gender': gender,
        'grade': grade,
      };

  factory MOUser.fromJson(Map<String, dynamic> map) {
    return MOUser(map['age'], map['schoolType'], map['gender'], map['grade'],
        map['hasPerformanceData']);
  }
}
