import '../models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  // aqui eu estou listando todos os elementos da classe Transaction na variavél transacions

  TransactionList(this.transactions);
  // o construtor irá receber os valores passados como parametros
  // do componente pai

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  "Nenhuma Transação Cadastrada!",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                // a informação será um tr que ira pegar os valores da lista transactions na posição index
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text('R\$${tr.value}'),
                        ),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(tr.date),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

//  Um forma de converter os valores passados em uma classe

// Aqui estou mapeando os elementos da lista para converte em
// elementos visuais ou seja, ele vai converter o elemento do tipo transaction
// para um elemento visual.
// ao final da função o uso do .tolist coloca todos os elementos convertidos em
// uma lista e mostra no visual

// children: transactions.map((tr) {

//   }).toList(),
// );
