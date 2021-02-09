import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(title: "Contador de pessoas", home: Home())); //Material App
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  int _pessoa = 0;
  String _mensagem = "Pode entrar!";

  void _changePeople(int delta) {
    setState(() {
      _pessoa += delta;
      if (_pessoa >= 20) {
        _mensagem = "Lotado, não pode entrar.";
        _pessoa = 20;
      } else if (_pessoa < 20 && _pessoa >= 0) {
        _mensagem = "Pode entrar!";
      } else {
        _pessoa = 0;
      }
    });
  }

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "Imagens/restaurante.jpg",
          fit: BoxFit.cover,
          height: 1000.0
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Pessoas:",
                    style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                  ), //text
                  Text(
                    "$_pessoa",
                    style:
                    TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                  ),
                ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: FlatButton(
                    child: Text(
                      "+1",
                      style: TextStyle(fontSize: 40.0, color: Colors.yellowAccent),
                    ),
                    onPressed: () {
                      _changePeople(1);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: FlatButton(
                    child: Text(
                      "-1",
                      style: TextStyle(fontSize: 40.0, color: Colors.red),
                    ),
                    onPressed: () {
                      _changePeople(-1);
                    },
                  ),
                ),
              ],
            ),
            Text(
              _mensagem,
              style: TextStyle(
                  color: Colors.blue,
                  fontStyle: FontStyle.italic,
                  fontSize: 35,
                  decoration: TextDecoration.none),
            ) //text
          ], //widget
        ) //Column
      ],
    );
  }
}