import 'package:flutter/material.dart';

import 'package:my_day/model/modeltasks.dart';

import 'package:my_day/view/homescreen.dart';
import 'package:my_day/view/tasks/my_tasks.dart';



class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController controltextAddTasktitle=TextEditingController();
  TextEditingController controltextAddTaskcontent=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Center(child: Text('Add task',style: TextStyle(color: Colors.white),)),
      backgroundColor: Colors.teal[200],),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children:[ Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30,),
           
            const SizedBox(height: 10,),
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  hintText: 'Enter a task',
                ),
              maxLines: 18,
              controller: controltextAddTaskcontent,
            ),
            TextButton(onPressed: (){
              var model=TaskData( content: controltextAddTaskcontent.text);
              taskControl.adddata(model);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: 'my app',),));
            }, child:Container(decoration: BoxDecoration(color: Colors.teal[400],
              borderRadius: const BorderRadius.all(Radius.circular(5))),
              height: 45,width: 120,
              child: const Center(child: Text("add task",style: TextStyle(color: Colors.white,fontSize: 20),))) )
          ],
              ),
        ]),
      ),);
  }
}