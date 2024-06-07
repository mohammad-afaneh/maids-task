import 'package:flutter/foundation.dart';
import 'package:maidstask/controller/apis.dart';

class Tasks extends ChangeNotifier {
  List<Map<String, dynamic>> _tasksList = [];

  List<Map<String, dynamic>> get tasksList => _tasksList;

  Tasks() {
    _tasksList = [];
    getTasks();
  }

  Future<void> getTasks() async {
    var res = await ApisManage().getTodos();
    _tasksList = List<Map<String, dynamic>>.from(
        res.map((item) => Map<String, dynamic>.from(item)));
    notifyListeners();
  }

  Future<void> addTask(todo) async {
    var res = await ApisManage().addTodos(todo);

    _tasksList.add({
      "id": res['id'].toString(),
      "todo": res['todo'].toString(),
      "completed": res['completed'].toString(),
      "userId": res['userId']
    });
    notifyListeners();
  }

  Future<void> toggleTaskCompletion(
    int index,
  ) async {
    var task = Map<String, dynamic>.from(_tasksList[index]);
    task['completed'] = (!bool.parse(task['completed'].toString())).toString();
    _tasksList[index] = task;

    notifyListeners();
    await ApisManage().updateTodos(task['id'], task['completed']);
  }

  Future<void> deleteTask(int index, id) async {
    _tasksList.removeAt(index);
    notifyListeners();
    await ApisManage().deleteTodos(id);
  }
}
