import 'package:act01/dashboard.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors
              .purple, // cor primaria que irá colori os elementos da aplicação. Aqui é um range de cores
          accentColor: Colors
              .amber, // ira realcçar alguns elementos especificos da aplicação
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                // aqui eu estou acessando as propriedades do themelight e fazendo uma copia destas.
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                button: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
      home: Dashboard(),
    );
  }
}
