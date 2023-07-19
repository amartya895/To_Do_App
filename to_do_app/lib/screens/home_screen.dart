// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:to_do_app/app_styles.dart/app_color.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/widgets/todo_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final todosList = ToDo.todoList();
  final _todocontroller = TextEditingController();

  bool _switchValue = false;

  List<ToDo> _foundTodo = [];

  @override
  void initState() {
    super.initState();
    _foundTodo = todosList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _switchValue ? styles.tdBlack : styles.tdBgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: _switchValue ? styles.tdBlack : styles.tdBgColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              color: _switchValue ? Colors.white : styles.tdBlack,
              size: 30,
            ),
            Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                child: Image.asset("assets/images/img_2.jpeg"),
                borderRadius: BorderRadius.circular(20),
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SearchBox(),
                Expanded(
                    child: ListView(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "All ToDos",
                              style: TextStyle(
                                  color: _switchValue
                                      ? Colors.white
                                      : styles.tdBlack,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500),
                            ),
                            Row(
                              children: [
                                Icon(Icons.light_mode_outlined),
                                Switch(
                                  value: _switchValue,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _switchValue = newValue;
                                    });
                                  },
                                ),
                                Icon(Icons.dark_mode_outlined)
                              ],
                            )
                          ],
                        )),
                    for (ToDo todoo in _foundTodo)
                      TodoItem(
                        todo: todoo,
                        onTodoChange: _handleTodoChange,
                        onDeleteItem: _handleOnDelete,
                      ),
                  ],
                ))
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: _switchValue ? styles.tdGrey : Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 10.0)
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todocontroller,
                    decoration: InputDecoration(
                        hintText: "Add New Todo item ",
                        border: InputBorder.none),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20, right: 20),
                child: ElevatedButton(
                  child: Text(
                    "+",
                    style: TextStyle(fontSize: 40),
                  ),
                  onPressed: () {
                    _addTodoItem(_todocontroller.text.toString());
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: styles.tdBlue,
                      elevation: 10,
                      minimumSize: Size(60, 60)),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }

  Widget SearchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _switchValue ? styles.tdGrey : Colors.white),
      child: TextField(
        onChanged: (value) => _runfilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: _switchValue ? Colors.white : styles.tdGrey,
              size: 20,
            ),
            hintText: "Search",
            hintStyle:
                TextStyle(color: _switchValue ? Colors.white : styles.tdGrey),
            prefixIconConstraints: BoxConstraints(minWidth: 25, maxHeight: 20)),
      ),
    );
  }

  void _runfilter(String EnteredKeyword) {
    List<ToDo> result = [];
    if (EnteredKeyword.isEmpty) {
      result = todosList;
    } else {
      result = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(EnteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundTodo = result;
    });
  }

  void _handleTodoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone!;
    });
  }

  void _handleOnDelete(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addTodoItem(String todo) {
    setState(() {
      todosList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo));
      FocusScopeNode currentFocus = FocusScope.of(context);
    });
    _todocontroller.clear();
  }
}
//FocusScopeNode currentFocus = FocusScope.of(context);
