import 'package:flutter/material.dart';
import 'package:flutter_quizz/widgets/Quizz.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _onPressed() {
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) =>
      new Quizz()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Card(
              elevation: 5,
              margin: EdgeInsets.only(bottom: 10),
              child: new Container(
                height: MediaQuery.of(context).size.width * 0.7,
                width: MediaQuery.of(context).size.width * 0.7,
                child: new Image.asset('assets/quizz_cover.jpg', fit: BoxFit.cover),
              ),
            ),
            new ElevatedButton(
                onPressed: _onPressed,
                child: Text('Démarrer le quizz'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  )
                )
            )
          ],
        ),
      ),
    );
  }
}