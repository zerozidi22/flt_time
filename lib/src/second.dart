import 'dart:async';
import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class second extends StatefulWidget {

  final String url;

  second({Key key, @required this.url}) : super(key: key);

  _secondState createState() => _secondState();
}

class _secondState extends State<second>{

  DateTime time = DateTime.now().add((new Duration(hours: 9)));
  var timer;

  Future<DateTime> getData() async {

    print("hi");
    http.Response response = await http.get(
        Uri.encodeFull('http://naver.com'),
        headers: {"Accept": "application/json"}
    );

    setState(() {
      time = HttpDate.parse(response.headers["date"]).add(new Duration(hours: 9));
    });

    timer = new Timer.periodic(Duration(seconds: 1), (timer) async {
      setState(() {
        time = time.add(new Duration(seconds: 1));
      });
    });

  }

  @override
  void dispose(){
    timer.cancel();
    super.dispose();
  }

  @override
  void initState(){
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  Container(
                    child: Text(
                        widget.url + "의 서버 시간",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40.0),
                    child: Text(
                        formatDate(time, [hh, '시 ', nn, '분 ', ss, '초 ', am]),
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        )
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 40.0),
                      child: RaisedButton(
                        color: Colors.blueAccent,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('고고!', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white )),
                      )
                  )
                ],
              ),
            )
        )
    );
  }
}
