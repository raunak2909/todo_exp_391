import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_exp_391/cubit_todo_db/cubit/todo_cubit.dart';
import 'package:todo_exp_391/db_helper.dart';
import 'package:todo_exp_391/provider_todo_db/db_provider.dart';
import 'package:todo_exp_391/provider_todo_db/ui/home_page.dart';

import 'cubit_todo_db/ui/home_page.dart';



void main() {
  runApp(MyTodoCubitApp());
}

class MyTodoProviderApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DbProvider(dbHelper: DbHelper.getInstance()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: HomePageP(),
      ),
    );
  }
}

class MyTodoCubitApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(dbHelper: DbHelper.getInstance()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: HomePage(),
      ),
    );
  }
}
