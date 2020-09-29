import 'package:mateop_engine/enum/enums.dart';

class Exercise {
  double firstOperator;
  double secondOperator;
  double answer;
  double playerAnswer;
  int hesitations;
  int dificulty;
  int loID;
  int type;
  OperationType operation;
  Duration duration;

  Exercise(
      {this.firstOperator,
      this.secondOperator,
      this.answer,
      this.playerAnswer,
      this.loID,
      this.type});

  Map<String, dynamic> toJson() => {
        'firstOperator': firstOperator,
        'secondOperator': secondOperator,
        'answer': answer,
        'player_answer': playerAnswer,
        'loID': loID,
        'type': type
      };

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
        firstOperator: json['firstOperator'],
        secondOperator: json['secondOperator'],
        answer: json['answer'],
        playerAnswer: json['player_answer'],
        loID: json['loID'],
        type: json['type']);
  }
}