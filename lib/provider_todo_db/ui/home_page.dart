import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_exp_391/provider_todo_db/ui/add_todo_page.dart';
import 'package:todo_exp_391/db_helper.dart';
import 'package:todo_exp_391/provider_todo_db/db_provider.dart';

class HomePageP extends StatefulWidget {
  @override
  State<HomePageP> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageP> {

  List<Map<String, dynamic>> mTodo = [];
  int filter = 0;

  @override
  void initState() {
    super.initState();
    ///Provider.of<DbProvider>(context, listen: false).fetchInitialTodos();
    context.read<DbProvider>().fetchInitialTodos();
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
              Expanded(child: ElevatedButton(onPressed: (){
                filter=2;
                ///Provider.of<DbProvider>(context, listen: false).fetchInitialTodos(filter: filter);
                context.read<DbProvider>().fetchInitialTodos(filter: filter);
              }, child: Text('Pending'))),
              SizedBox(
                width: 11,
              ),
              Expanded(child: ElevatedButton(onPressed: (){
                filter=1;
                ///Provider.of<DbProvider>(context, listen: false).fetchInitialTodos(filter: filter);
                context.read<DbProvider>().fetchInitialTodos(filter: filter);
              }, child: Text('Completed'))),
              SizedBox(
                width: 11,
              ),
              Expanded(child: ElevatedButton(onPressed: (){
                filter=0;
                ///Provider.of<DbProvider>(context, listen: false).fetchInitialTodos();
                context.read<DbProvider>().fetchInitialTodos(filter: filter);
              }, child: Text('All'))),
            ],
          ),
          Consumer<DbProvider>(
            builder: (ctx, provider, __){
              ///mTodo = context.watch<DbProvider>().getData();
              ///mTodo = ctx.watch<DbProvider>().getData();
              mTodo = provider.getData();
              return Expanded(
                child: mTodo.isNotEmpty
                    ? ListView.builder(
                    itemCount: mTodo.length,
                    itemBuilder: (_, index){
                      Color bgColor = Colors.grey.shade200;

                      if(mTodo[index]["t_priority"]==1){
                        bgColor = Colors.grey.shade200;
                      } else if(mTodo[index]["t_priority"]==2){
                        bgColor = Colors.yellow.shade200;
                      } else if(mTodo[index]["t_priority"]==3){
                        bgColor = Colors.red.shade200;
                      }

                      return InkWell(
                        onLongPress: (){
                          showModalBottomSheet(context: context, builder: (_){
                            return Container(
                              height: 200,
                              color: Colors.white,
                            );
                          });
                        },
                        child: CheckboxListTile(
                            tileColor: bgColor,
                            title: Text(mTodo[index]["t_title"], style: TextStyle(
                                decoration: mTodo[index]["t_isCompleted"]==1? TextDecoration.lineThrough : TextDecoration.none
                            ),),
                            subtitle: Text(mTodo[index]["t_desc"], style: TextStyle(
                                decoration: mTodo[index]["t_isCompleted"]==1? TextDecoration.lineThrough : TextDecoration.none
                            ),),
                            value: mTodo[index]["t_isCompleted"]==1, onChanged: (value) async{
                          ///Provider.of<DbProvider>(context, listen: false).isCompleted(id: mTodo[index]["t_id"], isCompleted: value!, filter: filter);
                          context.read<DbProvider>().isCompleted(id: mTodo[index]["t_id"], isCompleted: value!, filter: filter);
                        }),
                      );
                    })
                    : Center(child: Text('No Todo')),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTodoPageP(),));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
