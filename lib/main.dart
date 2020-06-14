import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:random_string/random_string.dart';
import 'package:sexmatch/appTheme.dart';
import 'package:sexmatch/elements/questions.dart';
import 'package:sexmatch/pages/gamePage.dart';

import 'elements/MySlider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var random;
  TextEditingController _textEditingController = new TextEditingController();
  String hintText = 'CODE';
  generationRandomCode(){
    random = randomAlphaNumeric(5);

    Firestore.instance.collection('games').document(random).get().then((value){
      if(value.data != null){
        generationRandomCode();
      }else{}
    }).catchError((e) => print(e));
  }

  @override
  void initState() {
    generationRandomCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    join(){
      _textEditingController.clear();
      showPlatformDialog(
        context: context,
        builder: (_) => PlatformAlertDialog(
          title: Text('Enter the code',textAlign: TextAlign.center),
          content: PlatformTextField(
            controller: _textEditingController,
            autofocus: true,
              material: (_, __)  => MaterialTextFieldData(
                decoration: new InputDecoration.collapsed(hintText: hintText)
              ),
              cupertino: (_, __) => CupertinoTextFieldData(
                  placeholder: hintText,
              )
          ),
          actions: <Widget>[
            PlatformDialogAction(
              child: Text('CANCLE'),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            PlatformDialogAction(
              child: Text('OK'),
              onPressed: (){
                if(_textEditingController.text != '') {
                  Firestore.instance.collection('games').document(
                      _textEditingController.text).get().then((value) {
                    if (value.data != null) {
                      List<dynamic> tmp = value.data['questions'];
                      Navigator.push(
                        context,
                        MySlider(builder: (context) =>
                            GamePage(code: _textEditingController.text, player: 'P2', enemy: 'P1', questions: tmp,)),
                      );
                    } else {
                      showPlatformDialog(
                        context: context,
                        builder: (_) =>
                            PlatformAlertDialog(
                              title: Text('ERROR'),
                              content: Text('Wrong Code'),
                              actions: <Widget>[
                                PlatformDialogAction(
                                  child: Text('CANCLE'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                      );
                      setState(() {
                        _textEditingController.clear();
                      });
                    }
                  });
                }else{
                  showPlatformDialog(
                    context: context,
                    builder: (_) =>
                        PlatformAlertDialog(
                          title: Text('ERROR'),
                          content: Text("Code can't be empty"),
                          actions: <Widget>[
                            PlatformDialogAction(
                              child: Text('CANCLE'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                  );
                }
              },
            ),
          ],
        ),
      );
    }

    start(){
      showPlatformDialog(
        context: context,
        builder: (_) => PlatformAlertDialog(
          title: Text('Your code', textAlign: TextAlign.center,),
          content: Text(random, textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
          actions: <Widget>[
            PlatformDialogAction(
              child: Text('CANCLE'),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            PlatformDialogAction(
              child: Text('OK'),
              onPressed: (){
                List<dynamic> tmp = Questions().setRandomQuestions();
                Map<dynamic, dynamic> map = {
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
                Firestore.instance.collection('games').document(random).setData({
                  'P1' : map,
                  'P2' : map,
                  'questions' : tmp,
                  'dataTime' : DateTime.now()
                }).catchError((e) => print(e)).whenComplete((){
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MySlider(builder: (context) => GamePage(code: random, player: 'P1', enemy: 'P2', questions: tmp,)),
                  );
                });
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
        resizeToAvoidBottomPadding: false,
      backgroundColor: AppTheme().getMainColor(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PlatformButton(
                onPressed: (){
                  start();
                },
                child: PlatformText('Start', style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),),
                material: (_, __)  => MaterialRaisedButtonData(
                  color: AppTheme().getMainColor()
                ),
                cupertino: (_, __) => CupertinoButtonData()
            ),
            Container(height: 50,),
            PlatformButton(
                onPressed: (){
                  join();
                },
                child: PlatformText('Join', style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),),
                material: (_, __)  => MaterialRaisedButtonData(
                  color: AppTheme().getMainColor(),
                ),
                cupertino: (_, __) => CupertinoButtonData()
            )
          ],
        ),
      ),
    );
  }
}

