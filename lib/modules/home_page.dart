import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/components/todo_item.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/model/todo_model.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  SharedPreferences? pref;
  TextEditingController tdcontroller = TextEditingController();
  final todosList = ToDo.todoList();
  List<ToDo> foundToDo = [];
  @override
  void initState() {
    foundToDo = todosList;
    setupToDo();
    super.initState();
  }

  List tdolist = [];
  Future setupToDo() async {
    pref = await SharedPreferences.getInstance();
    String todoText = pref!.getString('todo') ?? "";
    if (todoText.isNotEmpty) {
      tdolist = jsonDecode(todoText);
    }

    for (Map<String, dynamic> todo in tdolist) {
      setState(() {
        todosList.add(ToDo.fromJson(todo));
      });
    }
    return null;
  }

  void savetodo() {
    List items = foundToDo.map((e) => e.toJson()).toList();
    pref!.setString('todo', jsonEncode(items));
  }

  @override
  Widget build(BuildContext context) {
    void addToDoItem(String toDo) {
      setState(() {
        todosList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          tdtext: toDo,
        ));
        savetodo();
      });
      tdcontroller.clear();
    }

    void changeisCheck(ToDo todo) {
      setState(() {
        todo.ischeck = !todo.ischeck;
      });
      savetodo();
    }

    void deleteToDoItem(String id) {
      setState(() {
        todosList.removeWhere((item) => item.id == id);
      });
      savetodo();
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Todo List',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    // width: MediaQuery.of(context).size.width > 640 ? 600 : 500,
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: tdcontroller,
                      decoration: const InputDecoration(
                          hintText: 'Add a new todo item',
                          border: InputBorder.none),
                    ),
                    // width: 200,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      addToDoItem(tdcontroller.text);
                      savetodo();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            for (ToDo todoo in foundToDo.reversed)
              TodoItem(
                savetodo: savetodo,
                onchecked: changeisCheck,
                ondeleted: deleteToDoItem,
                todo: todoo,
              ),
          ],
        ),
      ),
    );
  }
}
