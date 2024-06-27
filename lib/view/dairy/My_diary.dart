import 'package:flutter/material.dart';
import 'package:my_day/control/dairy/dairy_control.dart';
import 'package:my_day/view/dairy/add_dairy.dart';
import 'package:my_day/view/dairy/content_diary.dart';
import 'package:my_day/view/dairy/update_dary.dart';
import 'package:my_day/view/homescreen.dart';
import 'package:lottie/lottie.dart';

DairyControl diaryControl = DairyControl();

class MyDiary extends StatefulWidget {
  const MyDiary({super.key});

  @override
  State<MyDiary> createState() => _MyDiaryState();
}

class _MyDiaryState extends State<MyDiary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[200],
          title: const Center(
            child: Text(
              'My diary',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () =>
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Adddairy(),
                    )),
                icon: const Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
            future: diaryControl.getdata(),
            builder: (context, snapshot) => snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => Apdatedairy(
                                            diaryData: snapshot.data![index]),
                                      )),
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () => showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                            height: 200,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  const Text(
                                                      'Are you sure you want to delete?'),
                                                  ElevatedButton(
                                                      child: const Text('sure'),
                                                      onPressed: () {
                                                        diaryControl.deletdada(
                                                            snapshot
                                                                .data![index]
                                                                .id,
                                                            context);
                                                        Navigator.of(context).pushReplacement(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    const MyHomePage(
                                                                        title:
                                                                            'my app')));
                                                      }),
                                                  ElevatedButton(
                                                    child: const Text('Cancel'),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                  icon: const Icon(Icons.delete))
                            ],
                          ),
                          title: Text(snapshot.data![index].title),
                          onTap: () => Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => ContentDairy(
                                content: snapshot.data![index].content),
                          )),
                        ),
                      );
                    },
                  )
                : Center(child: Lottie.asset('assets/lottie/water.json'))));
  }
}
