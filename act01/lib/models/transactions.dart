import 'package:flutter/foundation.dart';

// Aqui eu estou criando uma classe com modelo de objeto
// Na classe Transaction foram definidos os elementos que ela
// irá suportar e tipo desses elementos

// Para que os elementos dessa classe sejam acessados dentro 
// de uma função precisa passar os elementos dentro de um construtor
// que irá "contruir" esses elementos

// o uso da função @required torna o uso desses elementos obrigatorios
// o import foundation e para importar a função @required

class Transaction {
  final String id;
  final String title;
  final double value;
  final DateTime date;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.value,
    @required this.date
  });
}

