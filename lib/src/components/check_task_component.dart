import 'package:flutter/material.dart';

class CheckTaskComponent extends StatelessWidget {
  final String task;
  final bool check;
  final Function function;
  final Function removeFunction;

  const CheckTaskComponent(
      {Key key, this.task, this.check, this.function, this.removeFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: removeFunction,
      background: Container(
        color: Colors.red,
      ),
      child: CheckboxListTile(
        title: Text('Tarefa'),
        subtitle: Text(
          task,
          overflow: TextOverflow.ellipsis,
        ),
        value: check,
        onChanged: function,
      ),
    );
  }
}
