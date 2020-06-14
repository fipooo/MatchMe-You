import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sexmatch/elements/game.dart';
import 'package:sexmatch/elements/mySlider.dart';
import 'package:sexmatch/pages/resultPage.dart';

class FirebaseConnect{

  Future<bool> checkIfCodeAlreadyExist(var code) async {
    bool tmp = false;

    await Firestore.instance.collection('games').document(code).get().then((value){
      if(value.data == null)tmp=true;

    }).catchError((e) => print(e));

    return tmp;
  }

  setGameInformationOnStart(Game game) async {

    await Firestore.instance.collection('games').document(game.code).setData({
      'P1' : game.playerTwo,
      'P2' : game.playerTwo,
      'questions' : game.questions,
      'dataTime' : DateTime.now()
    }).catchError((e) => print(e)).whenComplete((){});
  }

  Future<dynamic> checkIfCodeExistAndConnectTo(var code) async {
    List<dynamic> returnList = [];

    await Firestore.instance.collection('games').document(code).get()
        .then((value) {
          if(value.data != null){
            returnList.add(true);
            returnList.add(value.data['questions']);
          }else{
            returnList.add(false);
          }
    }).catchError((e) => print(e));

    return returnList;
  }

  updatePlayerResult(var code, var player, var answers,
      BuildContext context, var enemy) async {
    await Firestore.instance.collection('games').document(code).updateData({
      player : {
        '1' : answers[0] ? 1 : 2,
        '2' : answers[1] ? 1 : 2,
        '3' : answers[2] ? 1 : 2,
        '4' : answers[3] ? 1 : 2,
        '5' : answers[4] ? 1 : 2,
        '6' : answers[5] ? 1 : 2,
        '7' : answers[6] ? 1 : 2,
        '8' : answers[7] ? 1 : 2,
        '9' : answers[8] ? 1 : 2,
        '10' : answers[9] ? 1 : 2,
      }
    }).whenComplete((){
      Navigator.pushReplacement(
        context,
        MySlider(builder: (context) => ResultPage(code: code, player: player, enemy: enemy)),
      );
    });
  }

  Future<dynamic> getQuestions(var code) async {

    List<dynamic> tmpLIST=[];

    await Firestore.instance.collection('games').document(code)
        .get().then((value){
          //print(value.data['questions']);
          tmpLIST = value.data['questions'];
          print(tmpLIST);
          //var tmp = value.data['questions'];
      //tmpLIST.addAll(tmp);
    }).catchError((e) => print(e)).whenComplete((){

    });
    print(tmpLIST.length);

    return tmpLIST;
  }



}