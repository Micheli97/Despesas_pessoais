import 'dart:math';
import 'package:act01/componets/chart.dart';
import 'package:act01/componets/transaction_form.dart';
import 'package:flutter/material.dart';
import 'componets/transaction_list.dart';
import 'models/transactions.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // A partir desse elemento e que os dados serão alterados na tela por isso o uso do stateful
  // Aqui eu estou listando os elementos que estao dentro da classe Transactions
  // e atribuindo valores estáticos a esses elementos
  // o uso da função Final torna os valores passados para os elementos da classe
  // imutaveis

  final List<Transaction> _transactions = [
    Transaction(
      id: "t1",
      title: 'Netflix',
      value: 32.90,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: "t2",
      title: 'Amazon',
      value: 10.00,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: "t3",
      title: 'Cash lol',
      value: 54.00,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: "t4",
      title: 'Internet',
      value: 100.00,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: "t5",
      title: 'Conta de luz',
      value: 150.00,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: "t5",
      title: 'Lanche',
      value: 50.00,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
  ];

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      // add valor randomico e converto o mesmo para string

      title: title,
      // primeiro title atributo, segundo title parametro passado na função

      value: value,
      date: date,
    );

    setState(() {
      // quando os valores recebidos forem passados para essa função
      // ele irá modificar o estado da lista e add todos os dados recebidos
      // a lista

      _transactions.add(newTransaction);
      // Aqui eu estou pegando os novos valores e add na lista transaction
      // aqui eu estou mudando o estado do componente newTransaction

      Navigator.of(context).pop();
      // o modal fecha quando atualiza o estado
    });
  }

  List<Transaction> get _recentTransactions {
    // pegandos todas as transações recentes
    return _transactions.where((tr) {
      // aque esta retornando um filtro de transações
      // ele vai filtrar as transaçoes e verificar se a data e de depois da subtração
      // do dia atual menos  dias
      // se for verdade ele vai retornar uma lista com as informações
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  // modal para mostrar formulario
  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // cabeçalho da aplicação
      appBar: AppBar(
        title: Text(
          "Despesas pessoais",
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          )
        ],
      ),

      // Corpo da aplicação
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_transactions,
                _removeTransaction), // comunicação direta = estou passando valores para o componente filho
            // aqui eu estou recebendo os dados add na lista transactions e
            // convertendo todos eles para elementos visuais com o componente
            // TransactionList
          ],
        ),
      ),

      // botao flutuante
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
    );
  }
}
