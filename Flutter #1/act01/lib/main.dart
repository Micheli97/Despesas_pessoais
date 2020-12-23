import 'package:act01/dashboard.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple, // cor primaria que irá colori os elementos da
        // aplicação. Aqui é um range de cores 
        accentColor: Colors.amber,  // ira realcçar alguns elementos especificos da aplicação
      ),
      home: Dashboard(),
    );
  }
}

