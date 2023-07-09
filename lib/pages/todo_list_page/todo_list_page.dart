import 'package:fittin_todo/models/todo_model.dart';
import 'package:fittin_todo/pages/todo_list_page/todo_add_page.dart';
import 'package:fittin_todo/pages/todo_list_page/todo_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<TodoModel> _todos = [];

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.background,
        centerTitle: true,
        title: Text(
          'Мои дела',
          style: themeData.textTheme.headlineSmall?.copyWith(),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 17,
            vertical: 5,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20,
              ),
            ),
          ),
          child: ListView.builder(
            itemCount: _todos.length,
            itemBuilder: (context, index) {
              return Slidable(
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (value) {
                        setState(() {
                          _todos.removeAt(index);
                        });
                      },
                      icon: Icons.delete,
                      backgroundColor: const Color(0xFFF85535),
                    ),
                  ],
                ),
                startActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (value) {
                        setState(() {
                          _todos[index].done
                              ? _todos[index] =
                                  _todos[index].copyWith(done: false)
                              : _todos[index] =
                                  _todos[index].copyWith(done: true);
                        });
                      },
                      icon: Icons.done,
                      backgroundColor: const Color(0xFF45B443),
                    )
                  ],
                ),
                child: GestureDetector(
                  onLongPress: () async {
                    modelToUpdate = _todos[index].copyWith(
                        text: _todos[index].text,
                        deadline: _todos[index].deadline);
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TodoEditPage()));
                    setState(
                      () {
                        if (delete) {
                          _todos.removeAt(index);
                          modelToUpdate = TodoModel(text: '');
                          delete = false;
                        } else if (back) {
                          back = false;
                        } else {
                          _todos[index] = TodoModel(
                              text: modelToUpdate.text,
                              deadline: modelToUpdate.deadline);
                        }
                        changed = false;
                      },
                    );
                  },
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _todos[index].done,
                    onChanged: (value) {
                      final checked = value ?? false;
                      setState(() {
                        _todos[index] = _todos[index].copyWith(
                          done: checked,
                        );
                      });
                    },
                    title: Text(
                      _todos[index].text.length <= 20
                          ? _todos[index].text
                          : '${_todos[index].text.substring(0, 20)}...',
                      style: TextStyle(
                        fontSize: 20,
                        height: 20 / 16,
                        color:
                            _todos[index].done ? Colors.black26 : Colors.black,
                        decoration: _todos[index].done
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationColor:
                            _todos[index].done ? Colors.black26 : Colors.black,
                        decorationThickness: 2,
                      ),
                    ),
                    subtitle: _todos[index].deadline != null
                        ? Text(DateFormat('dd-MM-yyyy')
                            .format(_todos[index].deadline!))
                        : null,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (context) => TodoAddPage()));
          setState(
            () {
              if (!cancel) {
                _todos.add(modelToAdd);
              } else {
                cancel = false;
              }
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
