import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 93, 227, 227)),
        useMaterial3: true,
      ),
      home: const TodoApp(),
    );
  }
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  late TextEditingController _titleController;
  late TextEditingController _detailController;
  final List<Map<String, String>> _todoList = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _detailController = TextEditingController();
  }

  void addTodoHandle(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add new task"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Task Title"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _detailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Task Details"),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _todoList.add({
                        'title': _titleController.text,
                        'details': _detailController.text,
                      });
                    });
                    _titleController.clear();
                    _detailController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Save"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _todoList.isEmpty
          ? const Center(child: Text('No tasks added yet!'))
          : ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(
                        255, 198, 243, 237), // สีพื้นหลังภายในกรอบ
                    border: Border.all(
                      color:
                          const Color.fromARGB(255, 30, 220, 233), // สีของกรอบ
                      width: 1, // ความหนาของกรอบ
                    ),
                    borderRadius: BorderRadius.circular(10), // มุมโค้งของกรอบ
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // เงาของกรอบ
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      _todoList[index]['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(_todoList[index]['details']!),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodoHandle(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
