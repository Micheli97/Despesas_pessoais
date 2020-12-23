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
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          final tr = transactions[index];
          // a informação será um tr que ira pegar os valores da lista transactions na posição index

          return Card(
              child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    // Theme.of(context).primaryColor - a partir de um método estatico theme, passando um contexto
                    // é possivel acessa algo que está em outro componente
                    width: 2,
                  ),
                ),
                padding: EdgeInsets.all(10),
                child: Text(
                  "R\$ ${tr.value.toStringAsFixed(2)}",

                  // .toStriingAsFixed add casas decimais
                  // aqui estou convertendo um valor do tipo double para string
                  // pois e o valor suportado pelo elemento Text()

                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    tr.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    DateFormat('d MMM y').format(tr.date),
                    // da mesma forma que foi acima tem que converter o valor data
                    // para string pois e o valor suportado pelo elemento Text
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ));
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
