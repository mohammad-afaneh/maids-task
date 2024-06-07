import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maidstask/controller/database_sqlite.dart';
import 'package:maidstask/utils/MySharedPreferences.dart';

class ApisManage {
  Login(email, pass) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode(
        {
          'username': email,
          'password': pass,
          'expiresInMins': 43200,
        },
      );
      var res = await http.post(Uri.parse('https://dummyjson.com/auth/login'),
          headers: headers, body: body);
      return jsonDecode(res.body);
    } catch (err) {}
  }

  getTodos() async {
    try {
      if (MySharedPreferences.isGetTasks == false) {
        var res = await http.get(
          Uri.parse(
              'https://dummyjson.com/todos/user/${MySharedPreferences.loginId}'),
        );
        MySharedPreferences.isGetTasks = true;

        var res2 = jsonDecode(res.body);

        for (var element in res2["todos"]) {
          await DatabaseHelper().insert({
            "id": element['id'].toString(),
            "todo": element['todo'].toString(),
            "completed": element['completed'].toString(),
            "userId": element['userId']
          });
        }
        return res2["todos"];
      } else {
        var res = await DatabaseHelper().getAllTasks();
        return res;
      }
    } catch (err) {}
  }

  addTodos(todo) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode(
        {
          'todo': todo,
          'completed': false,
          'userId': MySharedPreferences.loginId,
        },
      );
      var res = await http.post(Uri.parse('https://dummyjson.com/todos/add'),
          headers: headers, body: body);
      var decodeRes = jsonDecode(res.body);
      await DatabaseHelper().insert({
        "id": decodeRes['id'].toString(),
        "todo": decodeRes['todo'].toString(),
        "completed": decodeRes['completed'].toString(),
        "userId": decodeRes['userId']
      });
      return decodeRes;
    } catch (err) {}
  }

  updateTodos(id, completed) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode(
        {
          'completed': completed,
        },
      );
      var res = await http.put(Uri.parse('https://dummyjson.com/todos/$id'),
          headers: headers, body: body);
      await DatabaseHelper().updateTask(id, completed.toString());

      return jsonDecode(res.body);
    } catch (err) {}
  }

  deleteTodos(id) async {
    try {
      var res = await http.delete(
        Uri.parse('https://dummyjson.com/todos/$id'),
      );
      await DatabaseHelper().deleteTask(id);
      return jsonDecode(res.body);
    } catch (err) {}
  }
}
