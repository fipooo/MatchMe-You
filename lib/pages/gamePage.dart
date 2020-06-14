import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sexmatch/elements/mySlider.dart';
import 'package:sexmatch/elements/questions.dart';
import 'package:sexmatch/pages/resultPage.dart';
import 'package:sexmatch/services/firebaseConnect.dart';
import 'package:sexmatch/widgets/cardWidget.dart';

class GamePage extends StatefulWidget {
  GamePage(
      {Key key,
      @required this.code,
      @required this.player,
      @required this.enemy,
      @required this.questions})
      : super(key: key);

  final String code;
  final String player;
  final String enemy;
  final List<dynamic> questions;

  @override
  _GamePage createState() => _GamePage();
}

class _GamePage extends State<GamePage> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<String> textList;
  List<bool> answers = [];
  List<Widget> cardList = new List();
  bool set = false;
  int numbers = 10;
  Animatable<Color> background = TweenSequence<Color>(
    [
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Color.fromRGBO(89, 0, 127, 1),
          end: Color.fromRGBO(201, 76, 255, 1),
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Color.fromRGBO(201, 76, 255, 1),
          end: Color.fromRGBO(177, 0, 255, 1),
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Color.fromRGBO(177, 0, 255, 1),
          end: Color.fromRGBO(100, 38, 127, 1),
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Color.fromRGBO(100, 38, 127, 1),
          end: Color.fromRGBO(142, 0, 204, 1),
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Color.fromRGBO(142, 0, 204, 1),
          end: Color.fromRGBO(89, 0, 127, 1),
        ),
      ),
    ],
  );

  bool loading = true;

  List<String> imageList = [
    ('assets/bg.jpg'),
    ('assets/bg1.jpg'),
    ('assets/bg2.jpg'),
    ('assets/bg3.jpg'),
    ('assets/bg4.jpg'),
    ('assets/bg5.jpg'),
    ('assets/bg6.jpg'),
    ('assets/bg7.jpg'),
    ('assets/bg8.jpg'),
    ('assets/bg9.jpg'),
    ('assets/bg10.jpg'),
    ('assets/bg11.jpg'),
    ('assets/bg12.jpg'),
    ('assets/bg13.jpg'),
  ];

  loadingTime() async {
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    loadingTime();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    textList = Questions().getQuestions(widget.questions);
    imageList.shuffle();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _removeCard(index) {
    setState(() {
      cardList.removeAt(index);
      print(cardList.length);
    });
  }

  List<Widget> _getMatchCard(var height, var width) {
    cardList = new List();
    for (int x = 0; x < 10; x++) {
      cardList.add(
        Positioned(
          top: height * 0.15,
          left: width * 0.03,
          child: Draggable(
              onDragEnd: (drag) async {
                if (drag.offset.dx > 100 || drag.offset.dx < -100) {
                  _removeCard(x);

                  if (drag.offset.dx < 0)
                    answers.add(false);
                  else
                    answers.add(true);

                  Future.delayed(Duration(milliseconds: 500), () async {
                    if (cardList.length == 0) {
                      await FirebaseConnect().updatePlayerResult(widget.code,
                          widget.player, answers, context, widget.enemy);
                    }
                  });
                }
              },
              childWhenDragging: Container(),
              feedback: CardWidget().card(textList, x, height, width),
              child: CardWidget().card(textList, x, height, width)),
        ),
      );
    }

    return cardList;
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    if (!set) {
      _getMatchCard(height, width);
      setState(() {
        set = true;
      });
    } else {}

    return PlatformScaffold(
      appBar: loading
          ? null
          : PlatformAppBar(
              title: Text(
                widget.code,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.white.withOpacity(0.0),
              material: (_, __) => MaterialAppBarData(
                centerTitle: true,
                backgroundColor: Colors.purple.withOpacity(1.0),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
              cupertino: (_, __) => CupertinoNavigationBarData(
                  actionsForegroundColor: Colors.white),
            ),
      body: loading
          ? Container(
              width: width,
              height: height,
              child: Center(
                child: SpinKitFadingCube(
                  color: Colors.purple,
                  size: 150,
                ),
              ),
            )
          : AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  width: width,
                  height: height,
                  color: background
                      .evaluate(AlwaysStoppedAnimation(_controller.value)),
                  child: Center(
                    child: cardList.toList().length <= 0
                        ? Center(
                            child: SpinKitFadingCube(
                              color: Colors.white,
                              size: 150,
                            ),
                          )
                        : Stack(children: cardList),
                  ),
                );
              }),
    );
  }
}
