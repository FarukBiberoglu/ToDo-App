import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled11/models/todo_model.dart';

class DataBaseServices {
  static late Isar isar;

  // Isar başlatılsın
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([TodoSchema], directory: dir.path);
  }

  // Görev Eklen
  List<Todo> currentToDos = [];

  Future<void> addToDo(String text) async {
    final newToDo = Todo()..Text = text;
    await isar.writeTxn(() => isar.todos.put(newToDo)); // await eklendi
    await fetchTodos();
  }

  // Görevleri Getir
  Future<void> fetchTodos() async {
    currentToDos = await isar.todos.where().findAll();
  }

  // Görev Güncelle
  Future<void> updateToDo(
      {required int id, required String text, bool isDone = false}) async {
    final existingToDo = await isar.todos.get(id);
    if (existingToDo != null) {
      existingToDo
        ..Text = text
        ..isDone = isDone;
      await isar.writeTxn(() => isar.todos.put(existingToDo)); // await eklendi
    }
    await fetchTodos();
  }

  // Görev Sil
  Future<void> deleteToDo(int id) async {
    await isar.writeTxn(() => isar.todos.delete(id)); // await eklendi
    await fetchTodos();
  }
}
