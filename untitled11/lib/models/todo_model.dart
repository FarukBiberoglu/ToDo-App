import 'package:isar/isar.dart';

part 'todo_model.g.dart';

@collection
class Todo {
  Id id = Isar.autoIncrement;

  late String Text;
  DateTime dateTime = DateTime.now();
  bool isDone = false;

}