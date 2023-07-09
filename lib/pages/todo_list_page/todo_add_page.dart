import 'package:fittin_todo/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:fittin_todo/pages/todo_list_page/todo_list_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TodoAddPage extends StatefulWidget {
  const TodoAddPage({super.key});

  @override
  State<TodoAddPage> createState() => _TodoAddPageState();
}

TodoModel modelToAdd = TodoModel(text: 'data');
bool cancel = false;

class _TodoAddPageState extends State<TodoAddPage> {
  final myController = TextEditingController();

  DateTime? _date;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.background,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            cancel = true;
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                modelToAdd =
                    TodoModel(text: myController.text, deadline: _date);
              },
              child: Text('СОХРАНИТЬ',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    height: 14 / 20,
                    color: Color(0xFFFF9900),
                    fontWeight: FontWeight.bold,
                  ))),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Card(
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
              child: TextField(
                controller: myController,
                keyboardType: TextInputType.multiline,
                maxLines: 20,
                minLines: 7,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                    hintText: 'Здесь будут мои заметки...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 10,
                    )),
              ),
            ),
            ListTile(
                title: const Text('Дедлайн'),
                onTap: () async {
                  final res = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 100)),
                  );
                  setState(() {
                    _date = res;
                  });
                },
                subtitle: _date != null
                    ? Text(DateFormat('dd-MM-yyyy').format(_date!))
                    : null,
                trailing: Checkbox(
                  value: _date != null ? true : false,
                  onChanged: (value) {
                    setState(() {});
                  },
                ))
          ],
        ),
      ),
    );
  }
}
