import 'dart:math';
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

  _addTransaction(String title, double value) {
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

      Navigator.of(context).pop();
      // o modal fecha quando atualiza o estado
    });
  }


  // modal para mostrar formulario
  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
       context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        }
    );
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
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text("Gráfico"),
                elevation: 5,
              ),
            ),
            TransactionList(
                _transactions), // comunicação direta = estou passando valores para o componente filho
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
