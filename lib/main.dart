import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:random_string/random_string.dart';
import 'package:sexmatch/appTheme.dart';
import 'package:sexmatch/elements/game.dart';
import 'package:sexmatch/elements/questions.dart';
import 'package:sexmatch/pages/gamePage.dart';
import 'package:sexmatch/services/firebaseConnect.dart';
import 'package:sexmatch/widgets/customDialogs.dart';

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
  final TextEditingController _textEditingController =
      new TextEditingController();
  String hintText = 'CODE';

  getRandomCode() async {
    randomCode = randomAlphaNumeric(5);

    if (await FirebaseConnect().checkIfCodeAlreadyExist(randomCode)) {
    } else {
      getRandomCode();
    }
  }

  @override
  void initState() {
    getRandomCode();
    super.initState();
  }

  showJoinDialog() {
    showPlatformDialog(context: context, builder: (_) => CustomDialogs().joinCustomDialog(_textEditingController, context));
  }

  onJoinAction() {
    _textEditingController.clear();

    showJoinDialog();
  }

  onStartAction() {
    showPlatformDialog(
      context: context,
      builder: (_) => CustomDialogs().startCustomDialog(randomCode, context)
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
            PlatformText(
              'How well\nyou know me?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 50)),
            PlatformButton(
                onPressed: () {
                  onStartAction();
                  //FirebaseConnect().getQuestions('80C41');
                },
                child: PlatformText(
                  'Start',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                material: (_, __) =>
                    MaterialRaisedButtonData(color: AppTheme().getMainColor()),
                cupertino: (_, __) => CupertinoButtonData()),
            Container(
              height: 50,
            ),
            PlatformButton(
                onPressed: () {
                  onJoinAction();
                },
                child: PlatformText(
                  'Join',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                material: (_, __) => MaterialRaisedButtonData(
                      color: AppTheme().getMainColor(),
                    ),
                cupertino: (_, __) => CupertinoButtonData())
          ],
        ),
      ),
    );
  }
}
