import 'dart:ui';

class Questions{
  List<String> textList = [
    'I like black color',
    'I like red color',
    'I like blue color',
    'I like fast cars',
    'I want to be rich',
    'I have boyfriend/girlfriend',
    'I like dogs',
    'I like fly',
    'I like cats',
    'I like villages',
    'I like bungee',
    'I like chinese food',
    'I like parties',
    'I like alcohol',
    'I like weed'
  ];

  List<int> questionsNumbers = [0,1,2,3,4,5,6,7,8,9,];

  List<String> getTenQuestions(){
    textList.shuffle();
    List<String> tmpList = [];

    for(int i=0; i<10; i++){
      tmpList.add(textList[i]);
    }

    return tmpList;
  }

  List<dynamic> setRandomQuestions(){
    List<int> questionsNumbers = [];
    List<int> tmpList = [];

    for(int i =0; i<textList.length; i++){
      questionsNumbers.add(i);
    }

    questionsNumbers.shuffle();

    for(int i=0; i<10; i++){
      tmpList.add(questionsNumbers[i]);
    }

    return tmpList;
  }

  List<String> getQuestions(List<dynamic> dynamicList){
    List<String> tmp =[];
    for(int i =0; i<dynamicList.length; i++){
      tmp.add(textList[dynamicList[i]]);
    }
    return tmp;
  }

}