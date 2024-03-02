import 'package:flutter/material.dart';
import 'package:nanjamonja/src/game.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Toddles-Bobbles",
              style: TextStyle(fontSize: 30),
            ),
            Padding(padding: EdgeInsets.all(30)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => GameView(GameMode: 1,)));
              },
              child: Text("White"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white,foregroundColor: Colors.black),
            ),
            Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GameView(GameMode: 2,)));
                },
                child: Text("Green"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green,foregroundColor: Colors.white)),
          ],
        ),
      ),
    );
  }
}
