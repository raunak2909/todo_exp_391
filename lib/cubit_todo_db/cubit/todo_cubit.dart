import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_exp_391/cubit_todo_db/cubit/todo_state.dart';
import 'package:todo_exp_391/db_helper.dart';

class TodoCubit extends Cubit<TodoState> {
  DbHelper dbHelper;

  TodoCubit({required this.dbHelper}) : super(TodoState(todoList: []));

  void addTodo({
    required String title,
    required String desc,
    int priority = 1,
  }) async {
    bool check = await dbHelper.addTodo(
      title: title,
      desc: desc,
      priority: priority,
    );

    if(check){
      var mTodo = await dbHelper.fetchAllTodo();
      emit(TodoState(todoList: mTodo));
    }
  }

  void fetchInitialTodo({int filter = 1}) async{
    var mTodo = await dbHelper.fetchAllTodo(filter: filter);
    emit(TodoState(todoList: mTodo));
  }

  void updateTodoCompleted({required int id, required bool isCompleted}) async {
    bool check = await dbHelper.updateTodoCompleted(id: id, isCompleted: isCompleted);
    if(check){
      var mTodo = await dbHelper.fetchAllTodo();
      emit(TodoState(todoList: mTodo));
    }
  }
}
