import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:random_string/random_string.dart';
import 'package:sexmatch/appTheme.dart';
import 'package:sexmatch/elements/game.dart';
import 'package:sexmatch/pages/gamePage.dart';
import 'package:sexmatch/services/firebaseConnect.dart';

import 'elements/mySlider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  var randomCode;
  TextEditingController _textEditingController = new TextEditingController();
  String hintText = 'CODE';

  getRandomCode() async {
    
    randomCode = randomAlphaNumeric(5);
    
    if(await FirebaseConnect().checkIfCodeAlreadyExist(randomCode)){}else{
      getRandomCode();
    }
    
  }

  @override
  void initState() {
    getRandomCode();
    super.initState();
  }
  
  
  
  showJoinDialog(){
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
            onPressed: () async {
              if(_textEditingController.text != '') {

                List<dynamic> checkList = await FirebaseConnect()
                    .checkIfCodeExistAndConnectTo(_textEditingController.text);

                if(checkList[0]){
                  Navigator.push(
                    context,
                    MySlider(builder: (context) =>
                        GamePage(
                          code: _textEditingController.text,
                          player: 'P2',
                          enemy: 'P1',
                          questions: checkList[1],
                        )
                    ),
                  );
                }else{
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

  onJoinAction(){

    _textEditingController.clear();

    showJoinDialog();

  }

  onStartAction(){
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: Text('Your code', textAlign: TextAlign.center,),
        content: Text(randomCode, textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
        actions: <Widget>[
          PlatformDialogAction(
            child: Text('CLOSE'),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          PlatformDialogAction(
            child: Text('START'),
            onPressed: () async {
              
              Game _game = Game().createGame(randomCode);

              await FirebaseConnect().setGameInformationOnStart(_game);

              Navigator.pop(context);

              Navigator.push(
                  context,
                  MySlider(builder: (context) => GamePage(code: randomCode, player: 'P1', enemy: 'P2', questions: _game.questions,)));

            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomPadding: false,
      backgroundColor: AppTheme().getMainColor(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PlatformButton(
                onPressed: (){
                  onStartAction();
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
                  onJoinAction();
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