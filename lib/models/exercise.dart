import 'package:mateop_engine/enum/enums.dart';

class Exercise {
  double firstOperator;
  double secondOperator;
  double answer;
  double playerAnswer;
  int hesitations;
  int dificulty;
  int loID;
  OperationType operation;
  Duration duration;

  Exercise(
      {this.firstOperator,
      this.secondOperator,
      this.answer,
      this.playerAnswer,
      this.hesitations,
      this.dificulty,
      this.loID,
      this.operation,
      this.duration});

  Map<String, dynamic> toJson() => {
        'firstOperator': firstOperator,
        'secondOperator': secondOperator,
        'answer': answer,
        'player_answer': playerAnswer,
        'hesitations': hesitations,
        'dificulty': dificulty,
        'loID': loID,
        'type': operation.index,
        'duration': duration.inMilliseconds
      };

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
        firstOperator: json['firstOperator'],
        secondOperator: json['secondOperator'],
        answer: json['answer'],
        playerAnswer: json['player_answer'],
        hesitations: json['hesitations'],
        dificulty: json['hesitations'],
        loID: json['loID'],
        operation: OperationType.values[json['type']],
        duration: Duration(milliseconds: json['duration']));
  }

  bool checkAnswer() {
    return this.answer == this.playerAnswer;
  }
}
