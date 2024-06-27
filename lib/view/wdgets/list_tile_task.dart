import 'package:flutter/material.dart';
import 'package:my_day/control/tasks/tasks_control.dart';
import 'package:my_day/view/homescreen.dart';

class ListTileTask extends StatefulWidget {
  const ListTileTask({super.key, required this.snapshot, required this.index});
  final dynamic snapshot;
  final int index;
  @override
  State<ListTileTask> createState() => _ListTileTaskState();
}

class _ListTileTaskState extends State<ListTileTask> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            checkColor: Colors.black,
            fillColor: const MaterialStatePropertyAll(Colors.white70),
            value: isChecked,
            onChanged: (value) {
              isChecked = value!;
              setState(() {});
            },
          ),
          IconButton(
              onPressed: () => showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text('Are you sure you want to delete?'),
                              ElevatedButton(
                                  child: const Text('sure'),
                                  onPressed: () {
                                    taskControl.deletdada(
                                        widget.snapshot.data![widget.index].id,
                                        context);
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MyHomePage(
                                                    title: 'my app')));
                                  }),
                              ElevatedButton(
                                child: const Text('Cancel'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              icon: const Icon(Icons.delete)),
        ],
      ),
      title: Text(widget.snapshot![widget.index].content),
      onTap: () {
        isChecked = !isChecked;
        setState(() {});
      },
    );
  }
}
