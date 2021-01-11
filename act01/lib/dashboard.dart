import 'dart:io';
import 'dart:math';
import 'package:act01/componets/chart.dart';
import 'package:act01/componets/transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'componets/transaction_list.dart';
import 'models/transactions.dart';

// safeare diz qual dimensao segura na tela para colocar os elementos
// ela desconsidera espaços da tela que nao devem conter elementos
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with WidgetsBindingObserver {
  // widgetBindingObserver verifica se está havendo modificaçõe no estado da aplicação

  final List<Transaction> _transactions = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

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

  Widget _getIconButton(IconData icon, Function fn) {
    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list;
    final chartList = Platform.isIOS ? CupertinoIcons.refresh : Icons.pie_chart;

    final actions = [
      if (isLandscape)
        // se ele verificar que a tela está na horizontal irá mostrar os elementos abaixo
        _getIconButton(
          _showChart ? iconList : chartList,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        // aqui estou verificando qual é a plataforma para que o widget seja aplicado
        // de acordo com as suas caracteristicas padrao
        () => _openTransactionFormModal(context),
      )
    ];

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
                "Despesas pessoais"), // middle corresponde ao title do android
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              // equievale a função actions do android
              children: actions,
            ),
          )
        : AppBar(
            title: Text("Despesas pessoais"),
            actions: actions,
          );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;
    // MediaQuery modelo estatico pegando o contexto do aplicação, pegando o tamanho da altura
    // aqui eu estou calculando a altura da aplcação para aplicar o responsivo nos widgets da aplicação
    // nesse calculo eu estou subtraindo do tamanho disponivel a altura da appBar e da barra de status top

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // if (isLandscape)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text('Exibir Gráfico'),
            //       Switch.adaptive(
            //         // aqui ele vai verificar a plataforma e adpatar o componente para os padroes da mesma
            //         activeColor: Theme.of(context).accentColor,
            //         value: _showChart,
            //         onChanged: (value) {
            //           setState(() {
            //             _showChart = value;
            //           });
            //         },
            //       )
            //     ],
            //   ),
            // Aqui será a alternancia entre o grafico e a lista
            if (_showChart || !isLandscape)
              Container(
                height: availableHeight * (isLandscape ? 0.8 : 0.3),
                child: Chart(_recentTransactions),
              ),
            if (!_showChart || !isLandscape)
              Container(
                height: availableHeight * (isLandscape ? 1 : 0.7),
                child: TransactionList(_transactions, _removeTransaction),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _openTransactionFormModal(context),
                  ),
          );
  }
}
