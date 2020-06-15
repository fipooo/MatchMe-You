import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sexmatch/elements/questions.dart';
import 'package:sexmatch/services/firebaseConnect.dart';
import 'package:sexmatch/widgets/answersList.dart';
import 'package:sexmatch/widgets/percentRatio.dart';

class ResultPage extends StatefulWidget {
  ResultPage({Key key, this.title, @required this.code, @required this.player, @required this.enemy}) : super(key: key);
  final String title;
  final String code;
  final String player;
  final String enemy;

  @override
  _ResultPage createState() => _ResultPage();
}

class _ResultPage extends State<ResultPage> with SingleTickerProviderStateMixin{
  bool loading = true;
  bool resultReady = false;
  bool pageChange = true;
  List<String> textList = [];
  List<bool> answerYour;
  List<bool> answerEnemy;
  Map<dynamic, dynamic> list;
  Map<dynamic, dynamic> list2;

  getQuestions()async{
      List<dynamic> tmp = await FirebaseConnect().getQuestions(widget.code);
      textList = Questions().getQuestions(tmp);
      print(textList.length);
  }
  
  setLists(){
    answerYour= [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false
    ];
    answerEnemy= [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false
    ];
  }

  @override
  void initState() {
    setLists();
    getQuestions();
    super.initState();
  }

  Text waitingForOpponent(bool result){
    if(result){
      return Text('Calculating your\nresult', style: TextStyle(fontSize: 45, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,);
    }else{
      return Text('Waiting for second person', style: TextStyle(fontSize: 45, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,);
  }
  }

  checkIfOpponentEnd(bool checkBool){
    if(checkBool==false){
        resultReady=true;
      Future.delayed(Duration(seconds: 5), (){
        setState(() {
          pageChange=false;
        });
      });
    }
  }

  updateYourList(var listTmp, var updatedList, var listTmpEnemy, var updatedListEnemy){

    listTmp.forEach((key, value) {
      //print('$key : $value');
      switch (key) {
        case '1':
        //print('here');
          updatedList[0] = value==1 ? true : false;
          break;
        case '2':
          updatedList[1] = value==1 ? true : false;
          break;
        case '3':
          updatedList[2] = value==1 ? true : false;
          break;
        case '4':
          updatedList[3] = value==1 ? true : false;
          break;
        case '5':
          updatedList[4] = value==1 ? true : false;
          break;
        case '6':
          updatedList[5] = value==1 ? true : false;
          break;
        case '7':
          updatedList[6] = value==1 ? true : false;
          break;
        case '8':
          updatedList[7] = value==1 ? true : false;
          break;
        case '9':
          updatedList[8] = value==1 ? true : false;
          break;
        case '10':
          updatedList[9] = value==1 ? true : false;
          break;
      }
    });

    listTmpEnemy.forEach((key, value) {
      //print('$key : $value');
      switch (key) {
        case '1':
        //print('here');
          updatedListEnemy[0] = value==1 ? true : value==0 ? null : false;
          break;
        case '2':
          updatedListEnemy[1] = value==1 ? true : value==0 ? null : false;
          break;
        case '3':
          updatedListEnemy[2] = value==1 ? true : value==0 ? null : false;
          break;
        case '4':
          updatedListEnemy[3] = value==1 ? true : value==0 ? null : false;
          break;
        case '5':
          updatedListEnemy[4] = value==1 ? true : value==0 ? null : false;
          break;
        case '6':
          updatedListEnemy[5] = value==1 ? true : value==0 ? null : false;
          break;
        case '7':
          updatedListEnemy[6] = value==1 ? true : value==0 ? null : false;
          break;
        case '8':
          updatedListEnemy[7] = value==1 ? true : value==0 ? null : false;
          break;
        case '9':
          updatedListEnemy[8] = value==1 ? true : value==0 ? null : false;
          break;
        case '10':
          updatedListEnemy[9] = value==1 ? true : value==0 ? null : false;
          break;
      }
    });

  }

  updateEnemyList(var listTmp, var updatedList){
    listTmp.forEach((key, value) {
      //print('$key : $value');
      switch (key) {
        case '1':
        //print('here');
          updatedList[0] = value==1 ? true : value==0 ? null : false;
          break;
        case '2':
          updatedList[1] = value==1 ? true : value==0 ? null : false;
          break;
        case '3':
          updatedList[2] = value==1 ? true : value==0 ? null : false;
          break;
        case '4':
          updatedList[3] = value==1 ? true : value==0 ? null : false;
          break;
        case '5':
          updatedList[4] = value==1 ? true : value==0 ? null : false;
          break;
        case '6':
          updatedList[5] = value==1 ? true : value==0 ? null : false;
          break;
        case '7':
          updatedList[6] = value==1 ? true : value==0 ? null : false;
          break;
        case '8':
          updatedList[7] = value==1 ? true : value==0 ? null : false;
          break;
        case '9':
          updatedList[8] = value==1 ? true : value==0 ? null : false;
          break;
        case '10':
          updatedList[9] = value==1 ? true : value==0 ? null : false;
          break;
      }
    });
  }

  double percentCalculation(){
    int score = 0;

    for(int i=0; i<answerYour.length; i++){
      if(answerYour[i] == answerEnemy[i]){
        score=score+1;
      }
    }

    return score/answerYour.length;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var code= widget.code;

    return Scaffold(
      backgroundColor: Colors.purple,
      body: StreamBuilder(
        stream: Firestore.instance.collection('games').document(widget.code).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

          if(snapshot.data != null){
            if(snapshot.data.data[widget.enemy]['1'] == 0){
              print('WAITING');
            }
            else{
              checkIfOpponentEnd(false);

              //print(snapshot.data.data[widget.player]);
              //print(snapshot.data.data[widget.enemy]);

              setLists();

              list = snapshot.data.data[widget.player];

              list2 = snapshot.data.data[widget.enemy];

              updateYourList(list, answerYour, list2, answerEnemy);

              //updateYourList(list, answerYour);
            }
          }else{
            print('NULL');
          }
          //print(snapshot.data.data[widget.enemy]['0']);


          return PlatformScaffold(
            backgroundColor: Colors.purple,
            appBar: PlatformAppBar(
              backgroundColor: Colors.purple,
              title: Text('Yours answers. Code: $code', style: TextStyle(color: Colors.white),),
              material: (_, __)  => MaterialAppBarData(
                  centerTitle: true,
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                  actionsIconTheme: IconThemeData(
                    color: Colors.white,
                  )
              ),
              cupertino: (_, __) => CupertinoNavigationBarData(
                  actionsForegroundColor: Colors.white
              ),
            ),
            body: SafeArea(
              child: pageChange ? Container(
                width: width,
                height: height,
                //color: Colors.purple,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SpinKitThreeBounce(
                        color: Colors.white,
                        size: 50.0,
                      ),
                      waitingForOpponent(resultReady)
                    ],
                  ),
                ),
              ) :
              SingleChildScrollView(
                child: Container(
                  child: Column(
                      children: <Widget>[
                        PercentRatio().percentRatio(width: width, height: height, percent: percentCalculation()),
                        AnswerList().answerList(width: width, height: height,
                            answerEnemy: answerEnemy, answerYour: answerYour,
                            textList: textList),
                      ],
                    ),
                )
              ),
            ),
          );
          },
      ),
    );
  }
}
