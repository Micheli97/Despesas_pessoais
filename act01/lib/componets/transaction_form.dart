import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;
  // aqui eu estou passando string como o nome da nova transacao, double como valor da transacao
  // e o DateTime como o valor da data selecionada

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  // estado privado pois começa por _ (anderline)
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate =
      DateTime.now(); // aqui ele esta pegando o valor da data atual
  //DateTime _selectedDate; // ira armazenar o valor da data selecionado

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    // este modal ira retornar o DatePicker com o calendario
    showDatePicker(
      context: context,
      initialDate: DateTime.now(), // data inicial mostrando a data atual
      firstDate: DateTime(2020), // inicio de quando o caledario ira contar
      lastDate: DateTime.now(), // ultima data, no caso, a atual
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
    // funcao futuro que sera chamamda quando o usuario selecionar uma data
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _titleController,
                onChanged: (_) => _submitForm(),
                decoration: InputDecoration(
                  labelText: "Título",
                ),
              ),
              TextField(
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                // usa esse numberWithOptions porque no teclado numero do ios nao vem com separador
                //ai precisa add isso
                onChanged: (_) => _submitForm(),
                decoration: InputDecoration(
                  labelText: "Valor (R\$)",
                ),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'Nenhum data selecionada!'
                            : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                        // aqui estou verificando se a variavel _selectedDate é igual a null, se for ira retornar a frase
                        // Nenhuma data selecionda, se não irá retornar a data escolhida e formatada com o padrao internacional
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Selecionar Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _showDatePicker,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Text("Nova transação"),
                    color: Theme.of(context).primaryColor,
                    onPressed: _submitForm,
                    textColor: Theme.of(context).textTheme.button.color,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
