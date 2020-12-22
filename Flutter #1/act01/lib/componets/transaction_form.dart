import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  // Aqui eu estou usando essas variaveis para "pegarem" o valor
  // digitado no TextField

  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);
  // Aqui eu estou recebendo uma função do componente pai atravez do construtor

  _submitForm (){
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0){
      return;
    }

    onSubmit(title, value);
  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Título",
              ),
            ),
            TextField(
              controller: valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              // usa esse numberWithOptions porque no teclado numero do ios nao vem com separador  
              //ai precisa add isso
              decoration: InputDecoration(
                labelText: "Valor (R\$)",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text("Nova transação"),
                  textColor: Colors.purple,
                  onPressed: () {
                    final title = titleController.text;
                    final value = double.tryParse(valueController.text) ?? 0.0;
                    // aqui caso nao consiga converte o valor passado ele ira retornar 0.0
                    onSubmit(title, value);
                    // aqui eu estou chamamndo a função recebida pelo construtor
                    // e add os valores recebidos (title e value) 
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
