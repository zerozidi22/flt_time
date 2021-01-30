import 'dart:async';
import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class second extends StatefulWidget {

  final String url;

  second({Key key, @required this.url}) : super(key: key);

  _secondState createState() => _secondState();
}

class _secondState extends State<second>{

  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutter', 'firebase', 'admob'],
    testDevices: <String>[],
  );

  BannerAd bannerAd = BannerAd(
    adUnitId: BannerAd.testAdUnitId,
    size: AdSize.banner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("BannerAd event is $event");
    },
  );

  DateTime time = DateTime.now().add((new Duration(hours: 9)));
  var timer;

  Future<DateTime> getData() async {

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
    FirebaseAdMob.instance.initialize(
        appId: 'ca-app-pub-8632141287861541/3087954305'); // Android Test App ID
    bannerAd..load()..show();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  Container(
                      child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.asset('assets/img/time.gif')
                      )
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50.0),
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
                        child: Text('다시', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white )),
                      )
                  )
                ],
              ),
            )
        )
    );
  }
}
