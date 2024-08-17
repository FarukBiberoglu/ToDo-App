import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled11/models/todo_model.dart';
import 'package:untitled11/services/database_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _dataBaseService = DataBaseServices();
  final textEdittingController = TextEditingController();

  void getToDoList() async {
    await _dataBaseService.fetchTodos();
    setState(() {});
  }

  void addToDo() async {
    await _dataBaseService.addToDo(textEdittingController.text);
    textEdittingController.clear();
    setState(() {});
  }

  void upDateToDo(Todo todo) async {
    await _dataBaseService.updateToDo(
        id: todo.id, text: todo.Text, isDone: todo.isDone);
    setState(() {});
  }

  void deleteToDo(Todo todo) async {
    await _dataBaseService.deleteToDo(todo.id);
    setState(() {
      _dataBaseService.currentToDos.remove(todo); // Listenin güncellenmesi için setState içinde silme işlemi
    });
  }

  @override
  void initState() {
    super.initState();
    getToDoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Görev Uygulaması'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            _addToDoWidget(),
            _toDoListWidget(),
          ],
        ),
      ),
    );
  }

  Expanded _toDoListWidget() {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          final Todo toDo = _dataBaseService.currentToDos[index];

          return ListTile(
            title: Text(
              toDo.Text,
              style: TextStyle(
                decoration: toDo.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            tileColor: Colors.grey.shade100,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: toDo.isDone,
                  onChanged: (value) {
                    setState(() {
                      toDo.isDone = value!;
                      upDateToDo(toDo);
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    deleteToDo(toDo); // Silme işlemi
                  },
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(
          height: 0,
          color: Colors.blueGrey,
        ),
        itemCount: _dataBaseService.currentToDos.length,
      ),
    );
  }

  Container _addToDoWidget() {
    return Container(
      margin: EdgeInsets.all(20),
      child: TextField(
        controller: textEdittingController,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: addToDo,
            icon: Icon(Icons.add),
          ),
          border: OutlineInputBorder(),
          isDense: true,
          hintText: 'Bir şeyler Yazın',
        ),
      ),
    );
  }
}
