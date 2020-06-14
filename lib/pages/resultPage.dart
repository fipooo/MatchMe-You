import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sexmatch/elements/questions.dart';
import 'package:sexmatch/services/firebaseConnect.dart';

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

  getQuestions()async{
      List<dynamic> tmp = await FirebaseConnect().getQuestions(widget.code);
      textList = Questions().getQuestions(tmp);
      print(textList.length);
  }
  
  setLists(){
    var tmp = [
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
    
    answerYour = tmp;

    answerEnemy = tmp;
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

  updateYourList(var listTmp, var updatedList){
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

              Map<dynamic, dynamic> list = snapshot.data.data[widget.player];

              Map<dynamic, dynamic> list2 = snapshot.data.data[widget.enemy];

              updateYourList(list, answerYour);
              updateEnemyList(list2, answerEnemy);
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
              Container(
                width: width,
                height: height,
                child: Row(
                    children: <Widget> [
                      Container(
                        width: width*0.47,
                        height: height*0.9,
                        child: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            children: List.generate(10, (index) {
                              String asq = textList[index];
                              String asw = answerYour[index].toString();
                              String aswEnemy = answerEnemy[index].toString();
                              String you = widget.player;
                              return Container(
                                  height: height*0.08,
                                  color: (answerEnemy[index] == null) ? Colors.white : (answerEnemy[index] && answerYour[index]) ? Colors.green : (answerEnemy[index] != answerYour[index]) ? Colors.orangeAccent : Colors.red,
                                  child: Center(child: ListTile(title: Text('$asq?', style: TextStyle(fontSize: 16),    /*I:  $asw     He/She: $aswEnemy'*/),))
                              );
                            })
                        ),
                      ),
                      Container(
                        width: width*0.21,
                        height: height*0.9,
                        child: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            children: List.generate(10, (index) {
                              String asq = textList[index];
                              String asw = answerYour[index].toString();
                              String aswEnemy = answerEnemy[index].toString();
                              String you = widget.player;
                              return Container(
                                  height: height*0.08,
                                  color: answerYour[index] ? Colors.green : Colors.red,
                                  //color: (answerYour[index] && (answerenemy[index]== null ? false : answerenemy[index])) ? Colors.green : (!answerYour[index] && !(answerenemy[index]== null ? false : answerenemy[index])) ? Colors.red : Colors.orange,
                                  child: Center(child: ListTile(title: Text('I:  $asw'),))
                              );
                            })
                        ),
                      ),
                      Container(
                        width: width*0.32,
                        height: height*0.9,
                        child: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            children: List.generate(10, (index) {
                              String asq = textList[index];
                              String asw = answerYour[index].toString();
                              String aswEnemy = answerEnemy[index].toString();
                              String you = widget.player;
                              return Container(
                                  height: height*0.08,
                                  color: (answerEnemy[index]==null) ? Colors.orangeAccent : answerEnemy[index] ? Colors.green : Colors.red,
                                  child: Center(child: ListTile(title: Text('He/She: $aswEnemy'),))
                              );
                            })
                        ),
                      ),

                    ]
                ),
              ),
            ),
          );
          },
      ),
    );
  }
}
