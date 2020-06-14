import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ResultPage extends StatefulWidget {
  ResultPage({Key key, this.title,@required this.code, @required this.player, @required this.enemy}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String code;
  final String player;
  final String enemy;

  @override
  _ResultPage createState() => _ResultPage();
}

class _ResultPage extends State<ResultPage> with SingleTickerProviderStateMixin{
  bool loading = false;
  bool resultReady = false;
  bool pageChange = true;
  List<String> textList = [
    'Lubię kolor czarny',
    'Lubię kolor czerwony',
    'Lubię kolor niebieski',
    'Lubię szybkie auta',
    'Chce duzo zarabiac',
    'Mam żonę',
    'Jestem rasistą',
    'Lubię latać',
    'Lubię koty',
    'Lubię psy',
  ];

  @override
  void initState() {
    super.initState();
  }

  final spinkit = SpinKitSquareCircle(
    color: Colors.black,
    size: 50.0,
  );

  Text calculation(bool result){
    if(result){
      return Text('Calculating your\nresult', style: TextStyle(fontSize: 45, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,);
    }else{
      return Text('Waiting for second person', style: TextStyle(fontSize: 45, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,);
  }
  }

  checkIfIsFalse(bool checkBool){
    print(checkBool);
    if(checkBool==false){
        resultReady=true;
      Future.delayed(Duration(seconds: 5), (){
          pageChange=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Map<dynamic, dynamic> list2;
    List<bool> answerYour;
    List<bool> answerenemy=[null];

    String code = widget.code;
    return Scaffold(
      backgroundColor: Colors.purple,
      body: StreamBuilder(
        stream: Firestore.instance.collection('games').document(widget.code).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          loading = answerenemy[0] == null;
          checkIfIsFalse(loading);
          Future.delayed(Duration(seconds: 1), (){

          });

          if(answerenemy[0]== null && list2==snapshot.data.data[widget.enemy]){

          }
          else{

            Map<dynamic, dynamic> list = snapshot.data.data[widget.player];

            list2 = snapshot.data.data[widget.enemy];

            answerYour = [
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
            ];

            answerenemy = [
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
              false,
            ];

            list.forEach((key, value) {
              print('$key : $value');
              switch (key) {
                case '1':
                  print('here');
                  answerYour[0] = value==1 ? true : false;
                  break;
                case '2':
                  answerYour[1] = value==1 ? true : false;
                  break;
                case '3':
                  answerYour[2] = value==1 ? true : false;
                  break;
                case '4':
                  answerYour[3] = value==1 ? true : false;
                  break;
                case '5':
                  answerYour[4] = value==1 ? true : false;
                  break;
                case '6':
                  answerYour[5] = value==1 ? true : false;
                  break;
                case '7':
                  answerYour[6] = value==1 ? true : false;
                  break;
                case '8':
                  answerYour[7] = value==1 ? true : false;
                  break;
                case '9':
                  answerYour[8] = value==1 ? true : false;
                  break;
                case '10':
                  answerYour[9] = value==1 ? true : false;
                  break;
              }
            });

            list2.forEach((key, value) {
              print('$key : $value');
              switch (key) {
                case '1':
                  print('here');
                  answerenemy[0] = value==1 ? true : value==0 ? null : false;
                  break;
                case '2':
                  answerenemy[1] = value==1 ? true : value==0 ? null : false;
                  break;
                case '3':
                  answerenemy[2] = value==1 ? true : value==0 ? null : false;
                  break;
                case '4':
                  answerenemy[3] = value==1 ? true : value==0 ? null : false;
                  break;
                case '5':
                  answerenemy[4] = value==1 ? true : value==0 ? null : false;
                  break;
                case '6':
                  answerenemy[5] = value==1 ? true : value==0 ? null : false;
                  break;
                case '7':
                  answerenemy[6] = value==1 ? true : value==0 ? null : false;
                  break;
                case '8':
                  answerenemy[7] = value==1 ? true : value==0 ? null : false;
                  break;
                case '9':
                  answerenemy[8] = value==1 ? true : value==0 ? null : false;
                  break;
                case '10':
                  answerenemy[9] = value==1 ? true : value==0 ? null : false;
                  break;
              }
            });
            print(list);
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Text('Loading...');
            default:
              if (snapshot.data.data.isEmpty) {
                return Container();
              }
              return PlatformScaffold(
                backgroundColor: Colors.purple,
                appBar: PlatformAppBar(
                  backgroundColor: Colors.white,
                  title: Text('Yours answers. Code: $code', style: TextStyle(color: Colors.black),),
                  material: (_, __)  => MaterialAppBarData(
                    centerTitle: true,
                      iconTheme: IconThemeData(
                        color: Colors.black,
                      ),
                      actionsIconTheme: IconThemeData(
                        color: Colors.black,
                      )
                  ),
                  cupertino: (_, __) => CupertinoNavigationBarData(
                      actionsForegroundColor: Colors.black
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
                          calculation(resultReady)
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
                                String aswEnemy = answerenemy[index].toString();
                                String you = widget.player;
                                return Container(
                                  height: height*0.08,
                                    color: (answerenemy[index] == null) ? Colors.white : (answerenemy[index] && answerYour[index]) ? Colors.green : (answerenemy[index] != answerYour[index]) ? Colors.orangeAccent : Colors.red,
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
                                String aswEnemy = answerenemy[index].toString();
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
                                String aswEnemy = answerenemy[index].toString();
                                String you = widget.player;
                                return Container(
                                    height: height*0.08,
                                    color: (answerenemy[index]==null) ? Colors.orangeAccent : answerenemy[index] ? Colors.green : Colors.red,
                                    //color: (answerYour[index] && (answerenemy[index]== null ? false : answerenemy[index])) ? Colors.green : (!answerYour[index] && !(answerenemy[index]== null ? false : answerenemy[index])) ? Colors.red : Colors.orange,
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
          }
          },
      ),
    );
  }
}
