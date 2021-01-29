import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_time/src/home.dart';
import 'package:ft_time/src/second.dart';
import 'package:http/http.dart' as http;
import 'package:timer_builder/timer_builder.dart';
import 'package:date_format/date_format.dart';

class second extends StatefulWidget {

  final String url;

  second({Key key, @required this.url}) : super(key: key);

  _secondState createState() => _secondState();
}

class _secondState extends State<second>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(widget.url + "의 서버 시간"),
                TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
                  return Text(
                      formatDate(DateTime.now(), [hh, ':', nn, ':', ss, ' ', am]), // add pubspec.yaml the date_format: ^1.0.9
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w600,
                      )
                  );
                }),
                RaisedButton(onPressed: () { Navigator.pop(context); }, child: Text('뒤로가기')),
              ],
            )
        )
    );
  }
}
