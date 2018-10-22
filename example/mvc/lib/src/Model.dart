// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:path_provider/path_provider.dart';

import 'package:todos_repository_flutter/todos_repository_flutter.dart';
import 'package:todos_repository/todos_repository.dart';

import 'package:mvc/src/todo_list_model.dart';
import 'package:mvc/src/models.dart';

class Model {
  /// The rest of the app need not know of its existence.
  static final TodosRepository repository = TodosRepositoryFlutter(
    fileStorage: const FileStorage(
      'mvc_app',
      getApplicationDocumentsDirectory,
    ),
  );

  final todoModel = TodoListModel(repository: repository);

  VisibilityFilter get activeFilter => todoModel.activeFilter;

  set activeFilter(VisibilityFilter filter) {
    todoModel.activeFilter = filter;
  }

  List<Map> get todos => todoModel.todos.map(toMap).toList();

  bool get isLoading => todoModel.isLoading;

  Future loadTodos() {
    return todoModel.loadTodos();
  }

  List<Map> get filteredTodos => todoModel.filteredTodos.map(toMap).toList();

  void clearCompleted() {
    todoModel.clearCompleted();
  }

  void toggleAll() {
    todoModel.toggleAll();
  }

  /// updates a [To do] by replacing the item with the same id by the parameter
  void updateTodo(Map data) {
    todoModel.updateTodo(toTodo(data));
  }

  void removeTodo(Map data) {
    todoModel.removeTodo(toTodo(data));
  }

  void update(Map data) {
    Todo todo = toTodo(data);
    if (data['id'] == null) {
      todoModel.addTodo(todo);
    } else {
      todoModel.updateTodo(todo);
    }
  }

  void addTodo(Map data) {
    todoModel.addTodo(toTodo(data));
  }

  Map<String, Object> todoById(String id) {
    return toMap(todoModel.todoById(id)).cast<String, Object>();
  }

  /// Convert from a Map object
  static Todo toTodo(Map data) {
    return Todo(data['task'],
        complete: data['complete'], note: data['note'], id: data['id']);
  }

  /// Used to 'interface' with the View in the MVC design pattern.
  static Map toMap(Todo obj) => {
        "task": obj == null ? '' : obj.task,
        "note": obj == null ? '' : obj.note,
        "complete": obj == null ? false : obj.complete,
        "id": obj == null ? null : obj.id,
      };
}
