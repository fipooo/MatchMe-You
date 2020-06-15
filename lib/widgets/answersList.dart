import 'package:flutter/material.dart';
import 'package:sexmatch/settings/appTheme.dart';

class AnswerList{

  Row answerList({var width, var height, var textList, var answerEnemy, var answerYour}){
    return Row(
        children: <Widget> [
          Container(
            width: width*0.47,
            height: height*0.9,
            child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(10, (index) {
                  String asq = textList[index];
                  return Container(
                      height: height*0.08,
                      color: (answerEnemy[index] == null) ? Colors.white : (answerEnemy[index] && answerYour[index]) ? AppTheme().yesAnswer() : (answerEnemy[index] != answerYour[index]) ? AppTheme().noAndYesAnswer() : AppTheme().noAnswer(),
                      child: Center(child: ListTile(title: Text('$asq?', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),    /*I:  $asw     He/She: $aswEnemy'*/),))
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
                  String asw = answerYour[index].toString();
                  return Container(
                      height: height*0.08,
                      color: answerYour[index] ? AppTheme().yesAnswer() : AppTheme().noAnswer(),
                      child: Center(child: ListTile(title: Text('I:  $asw', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),), ))
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
                  String aswEnemy = answerEnemy[index].toString();
                  return Container(
                      height: height*0.08,
                      color: (answerEnemy[index]==null) ? AppTheme().noAndYesAnswer() : answerEnemy[index] ? AppTheme().yesAnswer() : AppTheme().noAnswer(),
                      child: Center(child: ListTile(title: Text('He/She: $aswEnemy',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),))
                  );
                })
            ),
          ),
        ]
    );
  }

}