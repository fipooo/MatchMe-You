import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:sexmatch/elements/mySlider.dart';
import 'package:sexmatch/elements/questions.dart';
import 'package:sexmatch/pages/resultPage.dart';

class GamePage extends StatefulWidget {
  GamePage({Key key, @required this.code, @required this.player, @required this.enemy, @required this.questions}) : super(key: key);

  final String code;
  final String player;
  final String enemy;
  final List<dynamic> questions;

  @override
  _GamePage createState() => _GamePage();
}

class _GamePage extends State<GamePage> with SingleTickerProviderStateMixin{
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

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    void _removeCard(index) {
      setState(() {
        cardList.removeAt(index);
        print(cardList.length);
      }
      );
    }

    List<Widget> _getMatchCard() {
      cardList = new List();
      for (int x = 0; x < 10; x++) {
        cardList.add(Positioned(
          top: height*0.1,
          left: width*0.05,
          child: Draggable(
            onDragEnd: (drag) async {
              if(drag.offset.dx>50 || drag.offset.dx<-50){
                _removeCard(x);
                print(drag.offset.dx);

                if(drag.offset.dx<0){
                  answers.add(false);
                  print('lewo');
                }else{
                  answers.add(true);
                  print('prawo');
                }

                Future.delayed(Duration(milliseconds: 500), (){
                  if(cardList.length == 0){
                    print('here');
                    Firestore.instance.collection('games').document(widget.code).updateData({
                      widget.player : {
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
                        MySlider(builder: (context) => ResultPage(code: widget.code, player: widget.player, enemy: widget.enemy)),
                      );
                    });

                  }
                });

              }

            },
            childWhenDragging: Container(),
            feedback: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                    child: Image.asset(
                      imageList[x],
                      width: width*0.9,
                      height: height*0.7,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(textList[x], style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                    ),
                    width: width*0.9,
                    height: height*0.7,
                  )
                ],
              ),
            ),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                    child: Image.asset(
                      imageList[x],
                      width: width*0.9,
                      height: height*0.7,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(textList[x], style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                    ),
                    width: width*0.9,
                    height: height*0.7,
                  )
                ],
              ),
            ),
          ),
        ),
        );
      }

      return cardList;
    }

    if(!set){
      _getMatchCard();
      setState(() {
        set=true;
      });
    }else{}

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(widget.code, style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.white.withOpacity(0.0),
        material: (_, __)  => MaterialAppBarData(
          centerTitle: true,
          backgroundColor: Colors.purple.withOpacity(1.0),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        cupertino: (_, __) => CupertinoNavigationBarData(
          actionsForegroundColor: Colors.white
        ),
      ),
      body: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              width: width,
              height: height,
              color: background
                  .evaluate(AlwaysStoppedAnimation(_controller.value)),
                child: Center(
                    child: cardList.toList().length<=0 ? Center(child: PlatformCircularProgressIndicator()) : Stack(
                        children: cardList),
                ),
            );
          }
      ),
    );
  }
}