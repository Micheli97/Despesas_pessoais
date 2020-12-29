import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  ChartBar({
    this.label,
    this.value,
    this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // a coluna foi envolvida com o layoutbuilder para ser possivel pegar
      //apenas o tamanho do componente e nao o da tela
      builder: (ctx, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text('${value.toStringAsFixed(2)}'),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                  // esse widget sobrepoe elementos
                  alignment: Alignment.bottomCenter,
                  // se nao usar o alinhamento o FractionallySizedBox fica orientado de cima para baixo
                  // o alignment corrige essa orientação
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        color: Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    FractionallySizedBox(
                      // sizedbox fracionado
                      heightFactor: percentage,
                      // o valor da altura sera o valor da porcentagem
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    )
                  ]),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                // o fittedbox foi usado para garantir o tamanho do texto
                child: Text(label),
              ),
            )
          ],
        );
      },
    );
  }
}
