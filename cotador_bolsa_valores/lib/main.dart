import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance/stock_price?format=json-cors&key=cb2df184";

void main() async {
  runApp(MaterialApp(
    home: MyApp(),
    theme: ThemeData(hintColor: Colors.green, primaryColor: Colors.white),
  ));
}

Future<Map> getData(String simbolo) async {
  http.Response response = await http.get(request+"&symbol="+simbolo);
  return json.decode(response.body);
}

class MyApp extends StatefulWidget {
  @override
  _InicialState createState() => _InicialState();
}

class _InicialState extends State<MyApp> {
  @override
  final simboloController = TextEditingController();
  String simbolo = "BIDI4";
  double _valorAcao = 0;

  void _simboloChange(String text) {
    if (text.isEmpty) {
      simboloController.text = "";
      return;
    }
    if (text.length > 4) {
      simbolo = simboloController.text.toUpperCase();
      getData(simbolo);
    }

  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text("Cotador da bolsa IBOVESPA"),
          centerTitle: true,
          backgroundColor: Colors.green),
      body: FutureBuilder<Map>(
        future: getData(simbolo),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                  child: Text(
                    "Carregando dados...",
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
            default:
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                      "Erro ao carregar dados...",
                      style: TextStyle(color: Colors.green, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
              } else {
                _valorAcao = snapshot.data['results'][simbolo.toUpperCase()]['price'];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.graphic_eq,
                          size: 150.0, color: Colors.green),
                      Divider(),
                      buildTextFormField(
                          "Simbolo da ação",
                          simboloController,
                          _simboloChange),
                      Divider(),
                      Text(
                          "Valor da ação: "+ simbolo,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.green, fontSize: 30.0)
                      ),
                      Divider(),
                      Text(
                        "R\$ "+_valorAcao.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green, fontSize: 30.0)
                      )
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }

  Widget buildTextFormField(String label,
      TextEditingController controller, Function f) {
    return TextField(
      onChanged: f,
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.green),
          border: OutlineInputBorder()
      ),
      style: TextStyle(color: Colors.green, fontSize: 25.0),
      keyboardType: TextInputType.text,
    );
  }
}
