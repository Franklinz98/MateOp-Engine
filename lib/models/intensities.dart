class Intensity {
  Map<String, double> loIntensities;
  List<double> loin0;
  List<double> loin1;
  List<double> loin2;
  List<double> loin3;
  List<double> loin4;

  Intensity({
    this.loin0,
    this.loin1,
    this.loin2,
    this.loin3,
    this.loin4,
  }) {
    try {
      loIntensities = Map<String, double>.from({
        'LOIN0': loin0[0],
        'LOIN1': loin2[0],
        'LOIN2': loin2[0],
        'LOIN3': loin3[0],
        'LOIN4': loin4[0],
        'LOINDF0': loin0[1],
        'LOINDF1': loin2[1],
        'LOINDF2': loin2[1],
        'LOINDF3': loin3[1],
        'LOINDF4': loin4[1],
        'LOINDD0': loin0[2],
        'LOINDD1': loin2[2],
        'LOINDD2': loin2[2],
        'LOINDD3': loin3[2],
        'LOINDD4': loin4[2],
      });
    } on Exception catch (e) {
      loIntensities = Map();
    }
  }

  factory Intensity.fromJson(Map<String, dynamic> map) {
    return Intensity(
        loin0: castList(map['LOIN0']),
        loin1: castList(map['LOIN1']),
        loin2: castList(map['LOIN2']),
        loin3: castList(map['LOIN3']),
        loin4: castList(map['LOIN4']));
  }

  Map get toJson {
    return {
      'LOIN0': loin0,
      'LOIN1': loin1,
      'LOIN2': loin2,
      'LOIN3': loin3,
      'LOIN4': loin4,
    };
  }

  static List<double> castList(List<dynamic> list) {
    List<double> listDouble = List();
    list.forEach((element) {
      listDouble.add(element.toDouble());
    });
    return listDouble;
  }

  int getNumberOfLo() {
    return loIntensities.length ~/ 3;
  }
}
