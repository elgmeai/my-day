import 'package:flutter/material.dart';
import 'package:my_day/model/modeldiary.dart';
import 'package:my_day/view/dairy/My_diary.dart';
import 'package:my_day/view/homescreen.dart';

class Adddairy extends StatefulWidget {
  const Adddairy({super.key});

  @override
  State<Adddairy> createState() => _AdddairyState();
}

class _AdddairyState extends State<Adddairy> {
  TextEditingController controltextaddDairytitle = TextEditingController();
  TextEditingController controltextaddDairycontent = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Add diary',
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: Colors.teal[200],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  hintText: 'Enter a title',
                ),
                maxLines: 1,
                controller: controltextaddDairytitle,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  hintText: 'Enter a title',
                ),
                maxLines: 18,
                controller: controltextaddDairycontent,
              ),
              TextButton(
                  onPressed: () {
                    var model = DiaryData(
                        title: controltextaddDairytitle.text,
                        content: controltextaddDairycontent.text);
                    diaryControl.adddata(model);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyHomePage(
                            title: 'my app',
                          ),
                        ));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.teal[400],
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      height: 45,
                      width: 120,
                      child: const Center(
                          child: Text(
                        "add",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ))))
            ],
          ),
        ]),
      ),
    );
  }
}
