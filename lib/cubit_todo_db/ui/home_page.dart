import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_exp_391/cubit_todo_db/cubit/todo_cubit.dart';
import 'package:todo_exp_391/cubit_todo_db/cubit/todo_state.dart';
import 'package:todo_exp_391/cubit_todo_db/ui/add_todo_page.dart';
import 'package:todo_exp_391/provider_todo_db/ui/add_todo_page.dart';
import 'package:todo_exp_391/db_helper.dart';
import 'package:todo_exp_391/provider_todo_db/db_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> mTodo = [];
  int filter = 0;

  @override
  void initState() {
    super.initState();
    context.read<TodoCubit>().fetchInitialTodo();
  }

  @override
  Widget build(BuildContext context) {
    ///mTodo = Provider.of<DbProvider>(context).getData();
    ///mTodo = context.watch<DbProvider>().getData();

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    filter = 2;
                    context.read<TodoCubit>().fetchInitialTodo(
                      filter: filter,
                    );
                  },
                  child: Text('Pending'),
                ),
              ),
              SizedBox(width: 11),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    filter = 1;

                    ///Provider.of<DbProvider>(context, listen: false).fetchInitialTodos(filter: filter);
                    context.read<TodoCubit>().fetchInitialTodo(
                      filter: filter,
                    );
                  },
                  child: Text('Completed'),
                ),
              ),
              SizedBox(width: 11),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    filter = 0;

                    context.read<TodoCubit>().fetchInitialTodo(
                      filter: filter,
                    );
                  },
                  child: Text('All'),
                ),
              ),
            ],
          ),
          BlocBuilder<TodoCubit, TodoState>(
            builder: (_, state) {
              mTodo = state.todoList;
              return Expanded(
                child: mTodo.isNotEmpty
                    ? ListView.builder(
                        itemCount: mTodo.length,
                        itemBuilder: (_, index) {
                          Color bgColor = Colors.grey.shade200;

                          if (mTodo[index]["t_priority"] == 1) {
                            bgColor = Colors.grey.shade200;
                          } else if (mTodo[index]["t_priority"] == 2) {
                            bgColor = Colors.yellow.shade200;
                          } else if (mTodo[index]["t_priority"] == 3) {
                            bgColor = Colors.red.shade200;
                          }

                          return InkWell(
                            onLongPress: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return Container(
                                    height: 200,
                                    color: Colors.white,
                                  );
                                },
                              );
                            },
                            child: CheckboxListTile(
                              tileColor: bgColor,
                              title: Text(
                                mTodo[index]["t_title"],
                                style: TextStyle(
                                  decoration: mTodo[index]["t_isCompleted"] == 1
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              subtitle: Text(
                                mTodo[index]["t_desc"],
                                style: TextStyle(
                                  decoration: mTodo[index]["t_isCompleted"] == 1
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              value: mTodo[index]["t_isCompleted"] == 1,
                              onChanged: (value) async {
                                context.read<TodoCubit>().updateTodoCompleted(
                                  id: mTodo[index]["t_id"],
                                  isCompleted: value!,
                                );
                              },
                            ),
                          );
                        },
                      )
                    : Center(child: Text('No Todos yet')),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTodoPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
