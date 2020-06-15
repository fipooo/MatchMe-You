import 'package:flutter/material.dart';

class AppTheme{
  
  Color getMainColor(){
    return Color.fromRGBO(196, 9, 154, 1);
  }

  Color yesAnswer(){
    return Colors.white.withOpacity(0.2);
  }

  Color noAnswer(){
    return Colors.black.withOpacity(0.2);
  }

  Color noAndYesAnswer(){
    return Colors.yellow.withOpacity(0.5);
  }
  
  
  
}