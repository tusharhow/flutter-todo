import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/controllers/todo_controllers.dart';
import 'package:provider/provider.dart';

import 'todo_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Consumer<TodoController>(
        builder: (context, val, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Bou TODO",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
           const   Text(
                "Make your life easy",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
          const    SizedBox(
                height: 20 * 4,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20,
                      ),
                      child: TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          hintText: 'Todo Title',
                          hintStyle: TextStyle(
                            color: Colors.white54,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white54,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white54,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white54,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white54,
                            ),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.white54,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*Please enter a title';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20,
                      ),
                      child: TextFormField(
                        controller: descController,
                        decoration: const InputDecoration(
                          hintText: 'Todo Description',
                          hintStyle: TextStyle(
                            color: Colors.white54,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white54,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white54,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white54,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white54,
                            ),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.white54,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*Please enter some text';
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20 * 4,
              ),
              GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    val
                        .addTodo(titleController.text, descController.text)
                        .then((value) => {
                              ScaffoldMessenger.of(context).showSnackBar(
                               const SnackBar(
                                  content: Text('Todo Added Successfully'),
                                  duration:  Duration(seconds: 2),
                                ),
                              ),
                              titleController.clear(),
                              descController.clear(),
                            });
                  }
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width / 1.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurpleAccent,
                  ),
                  child: const Center(
                    child: Text(
                      'Add Todo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  if (val.todos != null) {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const TodoList()));
                  } else {
                    print('No todos to show');
                  }
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width / 1.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepOrangeAccent,
                  ),
                  child: const Center(
                    child: Text(
                      'View Todos',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
