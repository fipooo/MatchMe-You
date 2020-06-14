import 'package:sexmatch/elements/questions.dart';

class Game{
  Map<dynamic, dynamic> playerOne;
  Map<dynamic, dynamic> playerTwo;
  var code;
  List<dynamic> questions;

  Game({this.playerOne, this.playerTwo, this.code, this.questions});

  Game createGame(var code){

    Map<dynamic, dynamic> tmpMap = {
      '1' : 0,
      '2' : 0,
      '3' : 0,
      '4' : 0,
      '5' : 0,
      '6' : 0,
      '7' : 0,
      '8' : 0,
      '9' : 0,
      '10' : 0,
    };

    List<dynamic> tmpQuestion = Questions().setRandomQuestions();

    return Game(playerOne: tmpMap, playerTwo: tmpMap, code: code, questions: tmpQuestion);

  }

}