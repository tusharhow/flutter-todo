import 'package:flutter/material.dart';
import 'package:flutter_todo/controllers/todo_controllers.dart';
import 'package:get/get.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          title: const Text(
            'Todo List',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.deepPurple,
        body: GetBuilder<TodoController>(builder: (val) {
          if (val.todos.length == 0) {
            return Center(
              child: Text(
                'No Todos',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            return Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: val.todos.length,
                  itemBuilder: (context, index) {
                    var data = val.todos[index];
                    return Dismissible(
                      background: Container(
                        color: Colors.red,
                      ),
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        val.deleteTodo(data.id!);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            "Todo Deleted Successfully",
                          ),
                          duration: Duration(seconds: 2),
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                          elevation: 5,
                          color: Colors.green[200],
                          margin: EdgeInsets.all(2),
                          child: ListTile(
                              title: Text(
                                data.title!,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(data.description!,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                  )),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.black38,
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Update Todo'),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Form(
                                                  key: formKey,
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                        controller: titleController
                                                                    .text
                                                                    .length >
                                                                0
                                                            ? titleController
                                                            : TextEditingController(
                                                                text:
                                                                    data.title),
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: 'Title',
                                                        ),
                                                        onChanged: (val) {
                                                          print(val);
                                                          if (val.length > 0) {
                                                            titleController
                                                                .text = val;
                                                          } else {
                                                            titleController
                                                                    .text =
                                                                data.title!;
                                                          }
                                                        },
                                                        validator: (val) {
                                                          if (val!.isEmpty) {
                                                            return '*Please enter some text';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      TextFormField(
                                                        controller: descController
                                                                    .text
                                                                    .length >
                                                                0
                                                            ? descController
                                                            : TextEditingController(
                                                                text: data
                                                                    .description),
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'Description',
                                                        ),
                                                        onChanged: (val) {
                                                          print(val);
                                                          if (val.length > 0) {
                                                            descController
                                                                .text = val;
                                                          } else {
                                                            descController
                                                                    .text =
                                                                data.description!;
                                                          }
                                                        },
                                                        validator: (val) {
                                                          if (val!.isEmpty) {
                                                            return '*Please enter some text';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    ],
                                                  ))
                                            ],
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              child: const Text('Cancel'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ElevatedButton(
                                              child: const Text('Save'),
                                              onPressed: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  val.updateTodo(
                                                      data.id!,
                                                      titleController.text,
                                                      descController.text);
                                                  titleController.clear();
                                                  descController.clear();
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content: Text(
                                                      "Todo Updated Successfully",
                                                    ),
                                                    duration:
                                                        Duration(seconds: 2),
                                                  ));
                                                  // val.getTodos();
                                                } else {}
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                              )),
                        ),
                      ),
                    );
                  },
                )),
              ],
            );
          }
        }));
  }
}
