import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_exp_391/cubit_todo_db/cubit/todo_cubit.dart';
import 'package:todo_exp_391/db_helper.dart';
import 'package:todo_exp_391/provider_todo_db/db_provider.dart';

class AddTodoPageP extends StatefulWidget {
  @override
  State<AddTodoPageP> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPageP> {
  var titleController = TextEditingController();

  var descController = TextEditingController();

  int priority = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Todo')),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hint: Text('Enter your title here..'),
                label: Text('Title'),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
              ),
            ),
            SizedBox(height: 11),
            TextField(
              controller: descController,
              maxLines: 4,
              minLines: 4,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                hint: Text('Enter your desc here..'),
                label: Text('Desc'),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
              ),
            ),
            SizedBox(height: 11),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RadioMenuButton(
                  value: 1,
                  groupValue: priority,
                  onChanged: (value) {
                    priority = value!;
                    setState(() {});
                  },
                  child: Text('Low'),
                ),
                RadioMenuButton(
                  value: 2,
                  groupValue: priority,
                  onChanged: (value) {
                    priority = value!;
                    setState(() {});
                  },
                  child: Text('Med'),
                ),
                RadioMenuButton(
                  value: 3,
                  groupValue: priority,
                  onChanged: (value) {
                    priority = value!;
                    setState(() {});
                  },
                  child: Text('High'),
                ),
              ],
            ),
            SizedBox(height: 11),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  context.read<TodoCubit>().addTodo(
                    title: titleController.text,
                    desc: descController.text,
                    priority: priority,
                  );
                  Navigator.pop(context);
                },
                child: Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
