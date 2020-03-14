import "dart:math";

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hand Washing Karaoke',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Hand Washing Karaoke'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _started = false;
  String lyrics = getLyrics();

  void _toggleStarted() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _started = !_started;
      lyrics = getLyrics();
    });
  }

  void _reset() {
    if (_started) {
      _toggleStarted();
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var children2;
    if (_started) {
      children2 = <Widget>[
        Text(
          lyrics,
          style: Theme.of(context).textTheme.title,
        ),
      ];
    } else {
      children2 = <Widget>[];
    }
    var icon;
    if (!_started) {
      icon = Icon(Icons.play_arrow);
    } else {
      icon = Icon(Icons.stop);
    }
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedContainer(
            onEnd: _reset,
            duration: Duration(seconds: _started == true ? 25 : 0),
            transform: Transform.translate(
                offset: Offset(
              0,
              _started == true
                  ? (MediaQuery.of(context).size.height * -0.5)
                  : (MediaQuery.of(context).size.height * 0.5),
            )).transform,
            child: Column(
              // Column is also layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: children2,
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleStarted,
        tooltip: _started ? 'Stop' : 'Play',
        child: icon,
      ),
    );
  }

  static String getLyrics() {
    var list = [
      'It’s gonna take a lot to drag me away from you\n\n There’s nothing that a hundred men or more could ever do\n\n I bless the rains down in Africa\n\n Gonna take some time to do the things we never had',
      'Feel the rain on your skin\n\n No one else can feel it for you\n\n Only you can let it in\n\n No one else, no one else\n\n Can speak the words on your lips\n\n Drench yourself in words unspoken\n\n Live your life with arms wide open\n\n Today is where your book begins\n\n The rest is still unwritten',
      'Ooh, baby, do you know what that’s worth?\n\n Ooh, heaven is a place on Earth\n\n They say in heaven love comes first\n\n We’ll make heaven a place on Earth\n\n Ooh, heaven is a place on Earth',
    ];

    final _random = new Random();

    return list[_random.nextInt(list.length)];
  }
}
