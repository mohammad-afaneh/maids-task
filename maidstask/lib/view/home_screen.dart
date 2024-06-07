import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/provider/tasks.dart';
import '../utils/flushbar/flushbar_meesage.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<Tasks>(builder: (context, Tasks tasksNotifier, child) {
      return Scaffold(
        backgroundColor: const Color.fromRGBO(234, 237, 245, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(64, 106, 179, 1),
          centerTitle: true,
          title: const Text(
            'Task Manager',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(labelText: 'New Task'),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        tasksNotifier.addTask(_controller.text);
                        _controller.clear();
                      } else {
                        Navigator.of(context).pop();
                        MyFlushbar()
                            .FlushbarMess('Please enter the task', context);
                      }
                    },
                  ),
                ],
              ),
            ),
            ListView.builder(
              itemCount: tasksNotifier.tasksList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    tasksNotifier.tasksList[index]['todo'],
                    style: TextStyle(
                      decoration: bool.parse(tasksNotifier.tasksList[index]
                                  ['completed']
                              .toString())
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  leading: IconButton(
                    icon: Icon(
                      bool.parse(tasksNotifier.tasksList[index]['completed']
                              .toString())
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                    ),
                    onPressed: () => tasksNotifier.toggleTaskCompletion(index),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => tasksNotifier.deleteTask(
                        index, tasksNotifier.tasksList[index]['id']),
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
