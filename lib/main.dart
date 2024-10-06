import 'package:flutter/material.dart';
void main() => runApp(const TaskManager());

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bootleg Window Scheduler ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Screen(),
    );
  }
}
class Task {
  String name;
  bool complete;
  Task({required this.name, this.complete = false});
}

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  final List<Task> lstOtasks = [];
  final TextEditingController taskControl = TextEditingController();

  void add() {
    if (taskControl.text.isNotEmpty) {
      setState(() {
        lstOtasks.add(Task(name: taskControl.text));
        taskControl.clear();
      });
    }
  }

  void toggle(int idx) {
    setState(() {
      lstOtasks[idx].complete = !lstOtasks[idx].complete;
    });
  }

  void delete(int idx) { //remove from list
    setState(() {
      lstOtasks.removeAt(idx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Scheuduler '),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.2),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskControl,
                    decoration: const InputDecoration(
                      labelText: 'Jott A Task',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: add,
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: lstOtasks.length,
              itemBuilder: (context, idx) {
                return ListTile(
                  leading: Checkbox(
                    value: lstOtasks[idx].complete,
                    onChanged: (value) {
                      toggle(idx);
                    },
                  ),
                  title: Text(
                    lstOtasks[idx].name,
                    style: TextStyle(
                      decoration: lstOtasks[idx].complete
                          ? TextDecoration.lineThrough //complete -strikethorough
                          : TextDecoration.underline, // not complete -underlined
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => delete(idx),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
