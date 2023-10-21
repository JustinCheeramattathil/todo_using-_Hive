import 'package:hive/hive.dart';
import 'package:todoapp/models/todo_model.dart';

class TodoService {
  final String _boxName = 'todo_database';

  Future<Box<TodoItem>> get _box async => await Hive.openBox<TodoItem>(_boxName);

  Future<void> addItem(TodoItem todoitem) async {
    var box = await _box;
    await box.add(todoitem);
  }

  Future<List<TodoItem>> getAllTodos() async {
    var box = await _box;
    return box.values.toList();
  }

  Future<void> delete(int index) async {
    var box = await _box;
    await box.deleteAt(index);
  }

  Future<void> update(int index,TodoItem todoItem) async {
    var box = await _box;
    todoItem.isCompleted = !todoItem.isCompleted;
    box.putAt(index,todoItem );
  }
}
