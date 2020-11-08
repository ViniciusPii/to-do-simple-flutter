import 'package:flutter/material.dart';

class TextFieldButtonComponent extends StatelessWidget {
  final Function function;
  final TextEditingController controller;

  const TextFieldButtonComponent({Key key, this.function, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 24),
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: 'Nova Tarefa', hintText: 'Ex: Pular Corda'),
              ),
            ),
          ),
          Container(
            width: 40,
            child: FloatingActionButton(
              backgroundColor: Colors.greenAccent[400],
              child: Icon(Icons.add),
              onPressed: function,
            ),
          )
        ],
      ),
    );
  }
}
