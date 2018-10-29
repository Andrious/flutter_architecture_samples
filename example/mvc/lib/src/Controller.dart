// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:mvc/src/todo_list_model.dart' show VisibilityFilter;
import 'package:mvc/src/Model.dart';

class Con extends ControllerMVC {
  Con() : super();

  static final model = Model();

  static VisibilityFilter get activeFilter => model.activeFilter;
  static set activeFilter(VisibilityFilter filter) =>
      model.activeFilter = filter;

  @override
  void initState() {
    /// Get a static reference to your view.
//    _stateView = stateView;
    cons = stateView.controllers([keyId]);
    con = stateView.con(keyId);
    loadTodos();
  }

//  static StateMVC _stateView;
  /// Access all the controllers also assigned to this controllers' view. (includes this on in the list)
  static Map<String, ControllerMVC> cons;

  /// Access to 'the first' controller in a possible list. Likely this very class.
  static Con con;

  static List<Map<dynamic, dynamic>> get todos => model.todos;

  static bool get isLoading => model.isLoading;

  Future loadTodos() async {
    var load = await model.loadTodos();
    refresh();
    return load;
  }

  static List<Map> get filteredTodos => model.filteredTodos;

  void clearCompleted() {
    model.clearCompleted();
    refresh();
  }

  void toggleAll() {
    model.toggleAll();
    refresh();
  }

  void updateTodo(Map<String, Object> data) {
    model.updateTodo(data);
    refresh();
  }

  void removeTodo(Map<String, Object> dataItem) {
    model.removeTodo(dataItem);
    refresh();
  }

  /// Updates the database. Either add a new data item or updating an existing one.
  void update(Map<String, Object> dataItem) {
    model.update(dataItem);
    refresh();
  }

  void addTodo(Map<String, Object> data) {
    model.addTodo(data);
    refresh();
  }

  static Map<String, Object> todoById(String id) {
    return model.todoById(id);
  }
}
