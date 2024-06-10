import 'package:exemplo_firebase/controller/todolist_controller.dart';
import 'package:exemplo_firebase/models/todolist.dart';
import 'package:flutter/material.dart';

class TodolistView extends StatefulWidget {
  final String userId;

  const TodolistView({Key? key, required this.userId}) : super(key: key);

  @override
  _TodolistViewState createState() => _TodolistViewState();
}

class _TodolistViewState extends State<TodolistView> {
  final TodolistController _controller = TodolistController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: FutureBuilder<List<Todolist>>(
        future: _controller.listar(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('An error has occurred!'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No items'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Todolist todo = snapshot.data![index];
                return ListTile(
                  title: Text(todo.titulo),
                  subtitle: Text(todo.userId),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _controller.delete(todo.id).then((_) {
                        setState(() {});
                      });
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Here you can implement the add functionality
          // For example, show a dialog to input the new todo item details
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
