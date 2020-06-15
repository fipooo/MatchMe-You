import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PercentRatio {
  Container percentRatio({var width, var height, var percent}) {
    double doublePercent = percent * 100;
    int textPercent = doublePercent.toInt();
    return Container(
        margin: EdgeInsets.only(top: 25),
        width: width,
        height: height * 0.35,
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
          ],
        ));
  }
}
