import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Point calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.yellow,
    Colors.cyan,
  ];

  static const List<String> names = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
  ];

  int numberOfPlayers = 4;
  List<int> points;
  List<int> calculatedPoints;

  @override
  void initState() {
    super.initState();
    this.points = List.filled(this.numberOfPlayers, 0);
    this.calculatedPoints = List.filled(this.numberOfPlayers, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "點數計算機",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: this.getPlayerNames(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: this.getTextFields(),
                ),
              ],
            ),
            FlatButton(
              onPressed: this.calculate,
              color: Colors.blue,
              child: Text(
                "計算",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: this.getPlayerNames(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: this.getResultTexts(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getPlayerNames() {
    List<Widget> texts = [];

    for (int i = 0; i < this.numberOfPlayers; i++) {
      texts.add(Expanded(
        child: Text(
          names[i],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: colors[i],
          ),
        ),
      ));
    }

    return texts;
  }

  List<Widget> getTextFields() {
    List<Widget> textFields = [];

    for (int i = 0; i < this.numberOfPlayers; i++) {
      textFields.add(
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 20,
              ),
              onChanged: (text) {
                this.points[i] = int.parse(text);
              },
            ),
          ),
        ),
      );
    }

    return textFields;
  }

  List<Widget> getResultTexts() {
    List<Widget> texts = [];

    for (int i = 0; i < this.numberOfPlayers; i++) {
      int score =
          this.calculatedPoints.isNotEmpty ? this.calculatedPoints[i] : 0;

      texts.add(Expanded(
        child: Text(
          score.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: score > 0
                ? Colors.green
                : (score < 0 ? Colors.red : Colors.black),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
    }

    return texts;
  }

  void calculate() {
    if (this.points.length != this.numberOfPlayers) {
      showDialog(context: context, child: Text("請輸入所有點數"));
      return;
    }

    this.calculatedPoints.fillRange(0, this.numberOfPlayers, 0);

    for (int calculatingPlayer = 0;
        calculatingPlayer < numberOfPlayers;
        calculatingPlayer++) {
      for (int rivals = 0; rivals < this.numberOfPlayers; rivals++) {
        this.calculatedPoints[calculatingPlayer] +=
            this.points[rivals] - this.points[calculatingPlayer];
      }
    }

    /// Update UI
    setState(() {});
  }
}
