import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:sexmatch/elements/game.dart';
import 'package:sexmatch/elements/mySlider.dart';
import 'package:sexmatch/pages/gamePage.dart';
import 'package:sexmatch/services/firebaseConnect.dart';

class CustomDialogs{

  Dialog customErrorDialog(String errorText, BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      //this right here
      child: Container(
        height: 250.0,
        width: 250.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                errorText,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 25.0)),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Card(
                color: Colors.red.withOpacity(0.8),
                child: Container(
                  height: 50,
                  width: 100,
                  child: Center(
                    child: Text(
                      'EXIT',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Dialog startCustomDialog(var code, BuildContext context) {
    return Dialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        child: Container(
          height: 250.0,
          width: 250.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Your Code',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  code,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Card(
                      color: Colors.red.withOpacity(0.8),
                      child: Container(
                        height: 50,
                        width: 100,
                        child: Center(
                          child: Text(
                            'EXIT',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Game _game = Game().createGame(code);

                      await FirebaseConnect().setGameInformationOnStart(_game);

                      Navigator.pop(context);

                      Navigator.push(
                          context,
                          MySlider(
                              builder: (context) => GamePage(
                                code: code,
                                player: 'P1',
                                enemy: 'P2',
                                questions: _game.questions,
                              )));

                    },
                    child: Card(
                      color: Colors.green,
                      child: Container(
                        height: 50,
                        width: 100,
                        child: Center(
                          child: Text(
                            'ENTER',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Dialog joinCustomDialog(TextEditingController _textEditingController, BuildContext context, ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      //this right here
      child: Container(
        height: 250.0,
        width: 250.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Enter your code',
                style: TextStyle(color: Colors.black, fontSize: 28),
              ),
            ),
            Container(
              width: 150,
              height: 50,
              child: PlatformTextField(
                  controller: _textEditingController,
                  autofocus: true,
                  material: (_, __) => MaterialTextFieldData(
                      decoration:
                      new InputDecoration.collapsed(hintText: 'CODE')),
                  cupertino: (_, __) => CupertinoTextFieldData(
                    placeholder: 'CODE',
                  )),
            ),
            Padding(padding: EdgeInsets.only(top: 25.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Card(
                    color: Colors.red.withOpacity(0.8),
                    child: Container(
                      height: 50,
                      width: 100,
                      child: Center(
                        child: Text(
                          'EXIT',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (_textEditingController.text != '') {
                      List<dynamic> checkList = await FirebaseConnect()
                          .checkIfCodeExistAndConnectTo(
                          _textEditingController.text);

                      if (checkList[0]) {
                        Navigator.push(
                          context,
                          MySlider(
                              builder: (context) => GamePage(
                                code: _textEditingController.text,
                                player: 'P2',
                                enemy: 'P1',
                                questions: checkList[1],
                              )),
                        );
                      } else {
                        showPlatformDialog(
                            context: context,
                            builder: (_) => customErrorDialog('Wrong Code', context));
                      }
                    } else {
                      showPlatformDialog(
                          context: context,
                          builder: (_) =>
                              customErrorDialog("Code can't be empty", context));
                    }
                  },
                  child: Card(
                    color: Colors.green,
                    child: Container(
                      height: 50,
                      width: 100,
                      child: Center(
                        child: Text(
                          'ENTER',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


}