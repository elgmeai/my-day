import 'package:flutter/material.dart';
import 'package:my_day/control/photo_control/photo_control.dart';
import 'package:my_day/view/homescreen.dart';
import 'package:lottie/lottie.dart';



PhotoControl photoControl =PhotoControl();

class MyPhoto extends StatefulWidget {
  const MyPhoto({super.key});

  @override
  State<MyPhoto> createState() => _MyPhotoState();
}

class _MyPhotoState extends State<MyPhoto> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[200],
          title: const Center(
            child: Text(
              'My photos',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                    photoControl.uploadphotocamer(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MyHomePage(title: 'my day',),
                    ));},
                icon: const Icon(Icons.camera_alt)),
                IconButton(
                onPressed: () {
                    photoControl.uploadphotogallery(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MyHomePage(title: 'my day',),
                    ));},
                icon: const Icon(Icons.file_present_sharp)),
          ],
        ),
        body: 
        
        FutureBuilder(
            future: photoControl.getphoto(),
            builder: (context, snapshot) => snapshot.hasData
                ? GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                 itemCount: snapshot.data!.length,
                 itemBuilder: (context, index) => 
                 Card(child: Container(
                  child:  Image(image: NetworkImage(snapshot.data![index].url),fit: BoxFit.fill,),
                 ),)
                 )
                : Center(child: Lottie.asset('assets/lottie/water.json'))));
  }
}
