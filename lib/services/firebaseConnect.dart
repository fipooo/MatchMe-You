import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sexmatch/elements/game.dart';

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

}