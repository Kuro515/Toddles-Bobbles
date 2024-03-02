import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// class Game extends StatelessWidget {
//   const Game({super.key,required this.mode});
//
//   final int mode;
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
//         useMaterial3: true,
//       ),
//       home: GameView(GameMode: mode,),
//     );
//   }
// }

class GameView extends StatefulWidget {
  const GameView({super.key,required this.GameMode});

  final int GameMode;

  @override
  State<GameView> createState() => _GameView();
}

class _GameView extends State<GameView> {
  int numbaerofcards = 60;
  int kindsofcards = 12;

  int nowcard = 0;

  List<int> cards = [];

  String path = '';

  bool isFinish = false;
  bool isStart = true;
  int Score = 0;

  @override
  void initState() {
    super.initState();
  }

  void ShuffleCard() {
    for (int i = 1; i <= 12; i++) {
      cards.addAll(List.filled(5, i));
    }
    Random random = Random();
    cards.shuffle(random);
    Score = 100;
    if(widget.GameMode == 1){
      path = 'assets/images/White/card${cards[nowcard]}.jpg';
    }else{
      path = 'assets/images/Green/card${cards[nowcard]}.jpg';
    }
    print(cards);
  }

  void StartGame() {
    ShuffleCard();
    setState(() {
      isStart = false;
    });
  }

  void NextCard() {
    setState(() {
      nowcard += 1;
      if (nowcard < 59) {
        Score += 100;
        if(widget.GameMode == 1){
          path = 'assets/images/White/card${cards[nowcard]}.jpg';
        }else{
          path = 'assets/images/Green/card${cards[nowcard]}.jpg';
        }
      } else if (nowcard == 59) {
        Score = 0;
        isFinish = true;
      } else if (nowcard >= 60) {
        nowcard = 0;
        isFinish = false;
        ShuffleCard();
      }
    });
  }

  void ResetScore() {
    setState(() {
      Score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    String title;
    if(widget.GameMode == 1){
      title = "White";
    }else{
      title = "Green";
    }
    if (isStart) {
      return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Are you ready?',
                  style: TextStyle(fontSize: 30),
                ),
                Padding(padding: EdgeInsets.all(10)),
                ElevatedButton(
                  onPressed: () {
                    StartGame();
                  },
                  child: Text("Start"),
                ),
              ],
            ),
          ));
    } else if (isFinish) {
      return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Finish!',
                  style: TextStyle(fontSize: 30),
                ),
                Padding(padding: EdgeInsets.all(10)),
                ElevatedButton(
                  onPressed: () {
                    NextCard();
                  },
                  child: Text("NewGame"),
                ),
              ],
            ),
          ));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Padding(padding: EdgeInsets.all(40)),

              SizedBox(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(child: child, scale: animation);
                  },
                  child: Image.asset(
                    path,
                    width: 300,
                    key: ValueKey<int>(nowcard),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(20)),
              ElevatedButton(
                onPressed: () {
                  NextCard();
                },
                child: Text("Next"),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                'Score: ${Score}',
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.redAccent),
              ),
              // Text((nowcard + 1).toString()),
              Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                  onPressed: () {
                    ResetScore();
                  },
                  child: Text("Reset")),
            ],
          ),
        ),
      );
    }
  }

  SizedBox CardImage() {
    if (!isFinish) {
      return SizedBox(
        child: Image.asset(
          path,
          width: 300,
        ),
      );
    } else {
      return SizedBox(
        width: 300,
        child: Text(
          "Finish!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30),
        ),
      );
    }
  }

  ElevatedButton btn() {
    String msg;
    if (isFinish) {
      msg = "NewGame";
    } else {
      msg = "Next";
    }
    return ElevatedButton(
      onPressed: () {
        NextCard();
      },
      child: Text(msg),
    );

    // }else{
    //     return ElevatedButton(
    //       onPressed: () {
    //         NextCard();
    //       },
    //       child: Text("Next"),
    //     );
    //   }
  }

  ElevatedButton? ResetBtn() {
    if (!isFinish) {
      return ElevatedButton(
          onPressed: () {
            ResetScore();
          },
          child: Text("Reset"));
    } else {
      return null;
    }
  }
}
