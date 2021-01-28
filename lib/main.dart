import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: fr(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }


class fr extends StatefulWidget {

  @override
  State createState() => _MyHomePageState();
}


class _MyHomePageState extends State<fr> {

  TextEditingController editController = new TextEditingController();

  Future<String> getData() async {
    http.Response response = await http.get(
      Uri.encodeFull('http://google.com'),
      headers: {"Accept": "application/json"}
    );

    print(response.headers);
  }

  goSecondPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondRoute(url: this.editController.text
      )),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              width: 300,
              child: TextField(
                  controller: editController,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    // labelText: 'Hint',
                  )
              )
            ),
            RaisedButton(onPressed: () { this.goSecondPage(); }, child: Text('RaisedButton')),
          ],
        ),
      ),
    );
  }


}




class FirstRoute extends StatelessWidget {

  Future<String> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull('http://google.com'),
        headers: {"Accept": "application/json"}
    );

    String time = "";

    response.headers.forEach((key, value) {
      if(key == "date") {
        time = value;
      }
    });
    return time;
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('First Route'),
      // ),
      body: Center(

        child: RaisedButton(
          child: Text('Open route'),
          onPressed: () {
            // String time = getData();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute(url: "j")),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {

  final String url;

  SecondRoute({Key key, @required this.url}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Second Route"),
      // ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
                width: 300,
                child: Text('$url 의 서버시간')
            ),
            // RaisedButton(onPressed: () { this.goSecondPage(); }, child: Text('RaisedButton')),
          ],
        ),
      ),
    );
  }
}