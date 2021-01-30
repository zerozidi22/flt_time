import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_time/src/second.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'second.dart';

class home extends StatefulWidget {

  @override
  State createState() => _MyHomePageState();
}


class _MyHomePageState extends State<home> {

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

  TextEditingController editController = new TextEditingController();

  goSecondPage() {

    this.editController.text ??= "google.com";

    if(this.editController.text == ""){
      this.editController.text = "google.com";
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => second(url: this.editController.text
      )),
    );
  }

  @override
  void initState(){
    FirebaseAdMob.instance.initialize(
        appId: 'ca-app-pub-8632141287861541/3087954305'); // Android Test App ID
    bannerAd..load()..show();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset('assets/img/ghost.png')
                )
            ),
            Container(
                width: 150,
                margin: const EdgeInsets.only(top: 100.0),
                child: TextField(
                    controller: editController,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "google.com"
                    )
                )
            ),
            Container(
                margin: const EdgeInsets.only(top: 15.0),
                child: RaisedButton(
                    color: Colors.blueAccent,
                    onPressed: () {
                      this.goSecondPage();
                    },
                    child: Text('고고!', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white ))
                )
            ),
          ],
        ),
      ),
    );
  }


}
