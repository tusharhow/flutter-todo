import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_todo/models/all_todos.dart';
import 'package:flutter_todo/models/generic_response.dart';
import 'package:flutter_todo/services/urls.dart';
import 'package:http/http.dart' as http;

class TodoController extends ChangeNotifier {
  Future<GenericResponse> addTodo(String title, String desc) async {
    final response = await http.post(
      Uri.parse("$BASE_URL/todo"),
      body: json.encode({
        'title': title,
        'description': desc,
      }),
    );
    if (response.statusCode == 200) {
      return GenericResponse.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to add todo');
    }
  }

  var todos = <GetTodosModel>[];

  Future<List<GetTodosModel>> getTodos() async {
    final response = await http.get(
      Uri.parse("$BASE_URL/todos"),
    );
    if (response.statusCode == 200) {
      print(response.body);
      todos.addAll(getTodosModelFromJson(response.body)!);
      notifyListeners();
      return todos;
    } else {
      print("$BASE_URL/todos");
      throw Exception('Failed to get todos');
    }
  }

  Future<GenericResponse> deleteTodo(String id) async {
    final response = await http.delete(
      Uri.parse("$BASE_URL/todo/$id"),
    );
    if (response.statusCode == 200) {
      print(response.body);
      return GenericResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to delete todo');
    }
  }

  Future updateTodo(String id, String title, String description) async {
    final response = await http.put(
      Uri.parse("$BASE_URL/todo/$id"),
      body: json.encode({
        'title': title,
        'description': description,
      }),
    );
    if (response.statusCode == 200) {
      print(response.body);
      notifyListeners();
    } else {
      throw Exception('Failed to update todo');
    }
  }
}
