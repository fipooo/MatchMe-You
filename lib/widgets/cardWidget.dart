import 'package:flutter/material.dart';

class CardWidget{
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
  Card card(var textList ,var index, var height, var width){
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            child: Image.asset(
              imageList[index],
              width: width*0.9,
              height: height*0.5,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: Center(
              child: Text(textList[index], style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            ),
            width: width*0.9,
            height: height*0.5,
          )
        ],
      ),
    );
  }
}