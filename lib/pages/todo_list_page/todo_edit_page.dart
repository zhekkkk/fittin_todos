import 'package:fittin_todo/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:fittin_todo/pages/todo_list_page/todo_list_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TodoEditPage extends StatefulWidget {
  const TodoEditPage({super.key});

  @override
  State<TodoEditPage> createState() => _TodoEditPageState();
}

TodoModel modelToUpdate = TodoModel(text: '');
bool delete = false;
bool back = false;
bool changed = false;

class _TodoEditPageState extends State<TodoEditPage> {
  final myController = TextEditingController();

  final String _text = modelToUpdate.text;
  DateTime? _date = modelToUpdate.deadline;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    if(!changed) {
      myController.text = _text;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.background,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            back = true;
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                modelToUpdate =
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
                    changed = true;
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
                )),
            TextButton(
              onPressed: () {
                delete = true;
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  const Icon(Icons.delete, color: Color(0xFFF85535)),
                  Text('Удалить',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        height: 14 / 20,
                        color: const Color(0xFFF85535),
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
