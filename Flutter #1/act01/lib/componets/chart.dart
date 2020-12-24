import 'package:act01/componets/chart_bar.dart';
import 'package:act01/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  // a partir dessa  recentTransaction; iremos obter os valores para calcular o valor
  // das transações e os dias da semana

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactions {
    // Passando uma chave == String e ira retornar um valor == Object
    // Object porque o valor pode ser variado de tipo, ex: string ou double etc
    return List.generate(7, (index) {
      // tamanho de 7 porque a semana tem 7 dias
      // a partir do generate é possivel gerar uma lista com ma quantidade definidade de
      // elementos
      // a lista precisa retornar alguma coisa do tipo <Map<String, Object>>
      final weekDay = DateTime.now().subtract(
        // aqui a variavel weekDay está recebendo a subtração do dia atual menos o valor
        // index que ira variar dinamicamente, tomando como referencia o dia atual
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        // a função DateTime.now() detem as informações do dia, mes e ano por isso está sendo feita essa verificação
        bool sameMoth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMoth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        // aqui ele pega os dias da semana
        // o pararmetro weekDay já tera o valor da subratação
        // ele vai formmatar a partir do dia da semana, que sera o valor weekDay, e irá pegar
        // a primeira letra do dia da semana

        'value': totalSum,
      };
      // aqui os valores retornados são estáticos
    });
  }

  double get _weekTotalValue{
    return groupedTransactions.fold(0.0, (sum, tr) {
      // o atributo fold funciona como reduce
      return sum += tr['value'];
      // o sum esta recebendo o valor inicial passado na função (0.0) e somando
      // com o valor da transação
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Row(
        children: groupedTransactions.map((tr) {
          // aqui eu estou mapeando os valores e 'transformando em elementos visuais'
          // return Text('${tr['day']}: ${tr['value']}:');
          return ChartBar(
            label: tr['day'],
            value: tr['value'],
            percentage: (tr['value'] as double) / _weekTotalValue,
          );
        }).toList(),
      ),
    );
  }
}
