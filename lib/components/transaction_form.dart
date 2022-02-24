import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    if(_selectedDate != null) {
      widget.onSubmit(title, value, _selectedDate!);
    }
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: "Titulo",
              ),
            ),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: "Valor (R\$)",
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? "Nenhuma data selecionada!"
                        : "Data Selecionada: ${DateFormat("dd/MM/y").format(_selectedDate!)}",
                  ),
                ),
                TextButton(
                  onPressed: _showDatePicker,
                  child: Text("Selecionar Data",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _submitForm();
                    print(_titleController.text);
                    print(_valueController.text);
                  },
                  child: const Text("Nova Transação"),
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(color: Colors.purple),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
