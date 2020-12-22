import 'dart:math';
import 'package:act01/componets/transaction_form.dart';
import 'package:act01/componets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:act01/models/transactions.dart';

class TransactionUser extends StatefulWidget {
  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
// A partir desse elemento e que os dados serão alterados na tela por isso o uso do stateful

  final _transactions = [
    Transaction(
        id: 't1',
        title: 'Novo Tênis de Corrida',
        value: 310.76,
        date: DateTime.now()),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now(),
    )
  ];

// Aqui eu estou listando os elementos que estao dentro da classe Transactions
// e atribuindo valores estáticos a esses elementos
// o uso da função Final torna os valores passados para os elementos da classe
// imutaveis

  _addTransaction(String title, double value){
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      // add valor randomico e converto o mesmo para string 
      title: title, 
      // primeiro title atributo, segundo title parametro passado na função
      value: value, 
      date: DateTime.now(),
      );

      setState(() {
        // quando os valores recebidos forem passados para essa função
        // ele irá modificar o estado da lista e add todos os dados recebidos
        // a lista
        _transactions.add(newTransaction);
        // Aqui eu estou pegando os novos valores e add na lista transaction
        // aqui eu estou mudando o estado do componente newTransaction
      });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TransactionList(_transactions), // comunicação direta = estou passando valores para o componente filho
        // aqui eu estou recebendo os dados add na lista transactions e
        // convertendo todos eles para elementos visuais com o componente
        // TransactionList
        
        TransactionForm(_addTransaction), // comunicação indireta = estou passando uma função para o componente filho
        // aqui eu estou passando a função _transactions para o componente TransactionList 
        // por meio do construtor
      ],
    );
  }
}
