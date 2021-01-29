import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_time/src/second.dart';
import 'package:http/http.dart' as http;
import 'second.dart';

class home extends StatefulWidget {

  @override
  State createState() => _MyHomePageState();
}


class _MyHomePageState extends State<home> {

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
      MaterialPageRoute(builder: (context) => second(url: this.editController.text
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
            RaisedButton(onPressed: () { this.goSecondPage(); }, child: Text('검색하기')),
          ],
        ),
      ),
    );
  }


}
