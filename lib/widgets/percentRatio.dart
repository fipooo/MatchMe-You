import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PercentRatio {

  List<String> textList = [
    "You are clearly new friends. To get to know each other better, keep playing or just talk more.",
    "It's not bad, however, you can always get to know each other better.",
    "You know each other really well. Few people know so much about themselves, congratulations.",
    "You don't have secrets for you! You are clearly your best friends!"
  ];

  Container percentRatio({var width, var height, var percent}) {
    double doublePercent = percent * 100;
    int textPercent = doublePercent.toInt();
    return Container(
        margin: EdgeInsets.only(top: 25),
        width: width,
        height: height * 0.55,
        child: Column(
          children: <Widget>[
            CircularPercentIndicator(
              radius: width * 0.5,
              lineWidth: 15.0,
              animationDuration: 1500,
              animation: true,
              backgroundColor: Colors.purple[800].withOpacity(0.5),
              percent: percent,
              center: new Text(
                "$textPercent%",
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              progressColor: Colors.white,
            ),
            Padding(padding: EdgeInsets.only(top: 25)),
            Text(
              'Your score is: $textPercent%',
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Text(
              percent<=0.2 ? textList[0] : percent<=0.4 ? textList[1] : percent<=0.6 ? textList[2] : textList[3],
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 21,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}
