import 'package:flutter/material.dart';
import 'package:todo_exp_391/db_helper.dart';

class DbProvider extends ChangeNotifier{
  DbHelper dbHelper;
  DbProvider({required this.dbHelper});

  List<Map<String, dynamic>> _allTodo = [];

  List<Map<String, dynamic>> getData () => _allTodo;

  ///events
  addTodo({required String title, required String desc, required int priority, int filter = 0}) async{
    bool check = await dbHelper.addTodo(title: title, desc: desc, priority: priority);
    if(check) {
      _allTodo = await dbHelper.fetchAllTodo(filter);
      notifyListeners();
    }
  }

  fetchInitialTodos({int filter = 0}) async{
    _allTodo = await dbHelper.fetchAllTodo(filter);
    notifyListeners();
  }

  isCompleted({bool isCompleted = false, required int id, int filter = 0}) async{
    bool check = await dbHelper.updateTodoCompleted(id: id, isCompleted: isCompleted);

    if(check){
      _allTodo = await dbHelper.fetchAllTodo(filter);
      notifyListeners();
    }
  }

}