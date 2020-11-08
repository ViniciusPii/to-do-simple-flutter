import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/src/components/check_task_component.dart';
import 'package:todo_app/src/components/text_field_button_component.dart';
import 'package:todo_app/src/models/item.dart';

class HomePage extends StatefulWidget {
  var items = new List<Item>();

  HomePage() {
    items = [];
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newTaskCtrl = TextEditingController();

  void changeTask(bool done, int index) {
    setState(() {
      widget.items[index].done = done;
      save();
    });
  }

  void add() {
    if (newTaskCtrl.text.isEmpty) return;
    setState(() {
      widget.items.add(
        Item(title: newTaskCtrl.text, done: false),
      );
      newTaskCtrl.text = "";
      save();
    });
    FocusScope.of(context).unfocus();
  }

  void remove(int index) {
    setState(() {
      widget.items.removeAt(index);
      save();
    });
  }

  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((x) => Item.fromJson(x)).toList();
      setState(() {
        widget.items = result;
      });
    }
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.items));
  }

  _HomePageState() {
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
      ),
      body: Column(
        children: [
          TextFieldButtonComponent(
            controller: newTaskCtrl,
            function: add,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = widget.items[index];
                return CheckTaskComponent(
                  task: item.title,
                  check: item.done,
                  function: (done) => changeTask(done, index),
                  removeFunction: (direction) => remove(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
