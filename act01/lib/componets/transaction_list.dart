import '../models/transactions.dart';
import 'package:flutter/material.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  // aqui eu estou listando todos os elementos da classe Transaction na variavél transacions
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);
  // o construtor irá receber os valores passados como parametros
  // do componente pai

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Nenhuma Transação Cadastrada!",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              // a informação será um tr que ira pegar os valores da lista transactions na posição index
              return TransactionItem(
                tr: tr,
                onRemove: onRemove,
              );
            },
          );
  }
}

// o metodo extract widget gera um novo componente e um mecanismo de refatoração
