import 'package:act01/componets/adaptative_button.dart';
import 'package:act01/componets/adaptative_date_picker.dart';
import 'package:act01/componets/adaptative_textfield.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;
  // aqui eu estou passando string como o nome da nova transacao, double como
  //valor da transacao
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

  @override
  void initState() {
    super.initState();
  }

  // Chamdo apenas 1 vez, na criação no widgte. Quando o widgete é inserido na widget tree

  //BUILD -  Chamado em diferentes situaçãoes. Sempre quue o widget prercisar ser reconstruído
  // após o initState() ou após a função setState() e até mesmo quando o widget for removido
  // da widget tree para ser inserido em outro ponto.

  // setState - Responsável por notificar nosso widgete que o estado interno foi alterado.
  // Por exemplpo, ao concluir uma requisição HTTP, querermos exibir estas informações na tela
  // Por isso, preechemos nossa tela com as informações recebidas e invocamos a função
  // setState()

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
  // Semprer que o seu widget sofrer alterações, este método é chamado e executado
  // antes do build(). Ou seja, sempre que chamar o setState(), este método é executado
  // Pode ser útil ao lidar com animações e/ou quando precisar ter acesso ao estado
  // antigo do widget

  @override
  void dispose() {
    super.dispose();
  }
  // chamado quando o widget for removido da widget tree permanentemente

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
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
              AdaptativeTextfield(
                label: "Título",
                controller: _titleController,
                onsubmitted: (_) => _submitForm(),
              ),
              AdaptativeTextfield(
                label: "Valor (R\$)",
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                // usa esse numberWithOptions porque no teclado numero do ios
                // nao vem com separador ai precisa add isso
                onsubmitted: (_) => _submitForm(),
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AdaptativeButton(
                    label: "Nova transação",
                    onPressed: _submitForm,
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
