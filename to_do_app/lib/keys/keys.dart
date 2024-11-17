import 'package:flutter/material.dart';
import 'package:to_do_app/todo_models.dart'; // Import mô hình Todo
import 'checkable_todo_item.dart'; // Import checkable todo item

class Keys extends StatefulWidget {
  const Keys({super.key});

  @override
  State<Keys> createState() {
    return _KeysState();
  }
}

class _KeysState extends State<Keys> {
  var _order = 'asc'; // Cờ sắp xếp tăng dần hay giảm dần
  final _todos = [
    const Todo(
      'Learn Flutter',
      Priority.urgent,
    ),
    const Todo(
      'Practice Flutter',
      Priority.normal,
    ),
    const Todo(
      'Explore other courses',
      Priority.low,
    ),
  ];

  List<Todo> get _orderedTodos {
    final sortedTodos = List.of(_todos);
    sortedTodos.sort((a, b) {
      final bComesAfterA = a.text.compareTo(b.text);
      return _order == 'asc' ? bComesAfterA : -bComesAfterA;
    });
    return sortedTodos;
  }

  void _changeOrder() {
    setState(() {
      _order = _order == 'asc' ? 'desc' : 'asc';
    });
  }

  void _addTodo() {
    setState(() {
      _todos.add(Todo(
        'New Task ${_todos.length + 1}',
        Priority.values[(_todos.length) % 3],
      ));
    });
  }

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addTodo,
          ),
        ],
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: _changeOrder,
              icon: Icon(
                _order == 'asc' ? Icons.arrow_downward : Icons.arrow_upward,
              ),
              label:
                  Text('Sort ${_order == 'asc' ? 'Descending' : 'Ascending'}'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _orderedTodos.length,
              itemBuilder: (ctx, index) {
                return Dismissible(
                  key: ValueKey(_orderedTodos[index].text),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) => _deleteTodo(index),
                  background: Container(
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 40,
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                  ),
                  child: CheckableTodoItem(
                    _orderedTodos[index].text,
                    _orderedTodos[index].priority,
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
