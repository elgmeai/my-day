import 'package:flutter/material.dart';
import 'package:my_day/control/tasks/tasks_control.dart';
import 'package:lottie/lottie.dart';
import 'package:my_day/view/tasks/add_task.dart';
import 'package:my_day/view/wdgets/list_tile_task.dart';

TaskControl taskControl = TaskControl();

class MyTasks extends StatefulWidget {
  const MyTasks({super.key});

  @override
  State<MyTasks> createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[200],
          title: const Center(
            child: Text(
              'My tasks',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddTask(),
                    )),
                icon: const Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
            future: taskControl.getdata(),
            builder: (context, snapshot) => snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child:
                            ListTileTask(snapshot: snapshot.data, index: index),
                      );
                    },
                  )
                : Center(child: Lottie.asset('assets/lottie/water.json'))));
  }
}
