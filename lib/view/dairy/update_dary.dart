import 'package:flutter/material.dart';
import 'package:my_day/model/modeldiary.dart';
import 'package:my_day/view/dairy/My_diary.dart';
import 'package:my_day/view/homescreen.dart';



class Apdatedairy extends StatefulWidget {
  final DiaryData diaryData;
  const Apdatedairy({super.key, required this.diaryData});

  @override
  State<Apdatedairy> createState() => _AdddairyState();
}

class _AdddairyState extends State<Apdatedairy> {
  @override
  void initState() {
        super.initState();
        controltextaddDairytitle.text=widget.diaryData.title;
        controltextaddDairycontent.text=widget.diaryData.content;
  }
  
 TextEditingController controltextaddDairytitle=TextEditingController();
  TextEditingController controltextaddDairycontent=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Center(child: Text('Update Dairy',style: TextStyle(color: Colors.white),)),
      backgroundColor: Colors.teal[200],),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children:[ Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10,),
            TextFormField(textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
                  
                ),
              maxLines: 1,
              controller: controltextaddDairytitle,
            ),
            const SizedBox(height: 10,),
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  
                ),
              maxLines: 18,
              controller: controltextaddDairycontent,
            ),
            TextButton(onPressed: (){
              var model=DiaryData(title: controltextaddDairytitle.text, content: controltextaddDairycontent.text,id: widget.diaryData.id);
              diaryControl.updatedata(model);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: 'my app',),));
            }, child:Container(decoration: BoxDecoration(color: Colors.teal[400],
              borderRadius: const BorderRadius.all(Radius.circular(5))),
              height: 45,width: 120,
              child: const Center(child: Text("update",style: TextStyle(color: Colors.white,fontSize: 20),))) )
          ],
              ),
        ]),
      ),);
  }
}