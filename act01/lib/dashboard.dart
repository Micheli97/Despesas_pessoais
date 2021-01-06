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
      id: "t7",
      title: 'pastel',
      value: 30.00,
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

  bool _showChart = false;
  // variavel de controle que irá receber um valor booleano para
  //mostrar ou não o gráfico

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);

      Navigator.of(context).pop();
    });
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      // Here he is returning a transaction filter;
      // It will filter the transations and check if the date. After he will subtract
      // the days minus the defined duration;
      // if true he will go return a list with informations.
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

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text(
        "Despesas pessoais",
        // style: TextStyle(
        //   fontSize: 20 * MediaQuery.of(context).textScaleFactor,
        //   // essa propriedade deixa os textos responsivos
        // ),
      ),
      actions: [
        if (isLandscape)
          // se ele verificar que a tela está na horizontal irá mostrar os elementos abaixo
          IconButton(
              icon: Icon(_showChart ? Icons.list : Icons.pie_chart),
              onPressed: () {
                setState(() {
                  _showChart = !_showChart;
                });
              }),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        )
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    // MediaQuery modelo estatico pegando o contexto do aplicação, pegando o tamanho da altura
    // aqui eu estou calculando a altura da aplcação para aplicar o responsivo nos widgets da aplicação
    // nesse calculo eu estou subtraindo do tamanho disponivel a altura da appBar e da barra de status top

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // if (isLandscape)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text('Exibir Gráfico'),
            //       Switch(
            //         value: _showChart,
            //         onChanged: (value) {
            //           setState(() {
            //             _showChart = value;
            //           });
            //         },
            //       )
            //     ],
            //   )
            // Aqui será a alternancia entre o grafico e a lista
            if (_showChart || !isLandscape)
              // se o showChart for verdadeiro irá mostrar o container abaixo
              Container(
                height: availableHeight *
                    (isLandscape
                        ? 0.7
                        : 0.3), // se ele estiver em modo retrato irá mostrar
                // a altura do gráfico multiplicado por 0.7 se não mostrará multiplicado por 0.3
                child: Chart(_recentTransactions),
              )
            // se a verificação acima nao for verdade ele ira retornar esse container
            // aqui eu apliquei um container nesse widget para poder aplicar o responsivo na altura dele
            else if (!_showChart || !isLandscape)
              Container(
                height: availableHeight * 0.7,
                child: TransactionList(_transactions, _removeTransaction),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
    );
  }
}
