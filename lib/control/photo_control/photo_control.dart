import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_day/model/modelphoto.dart';
import 'package:my_day/view/homescreen.dart';

final storage =
    FirebaseStorage.instance.ref();

class PhotoControl {
  uploadphotocamer(context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    var a = photo!.name;

    final fileref1 = storage.child('images/$a');

    File filecamerapath = File(photo.path);

    try {
      
      await fileref1.putFile(filecamerapath);
     final url=await fileref1.getDownloadURL();
     await adddphoto(url);
    } on FirebaseException catch (e) {
      print(e);
    }
    
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: 'my app',),),(Route<dynamic> route) => true);
  }

  uploadphotogallery(context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    String b = image!.name;
    final fileref2 = storage.child('images/$b');
    File filegallerypath = File(image.path);

    try {
      await fileref2.putFile(filegallerypath);
     final url=await fileref2.getDownloadURL();
    await adddphoto(url);

    } on FirebaseException catch (e) {
      print(e);
    }
 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: 'my app',),),(Route<dynamic> route) => true);
  }

  adddphoto(url) async {
   
    final user = <String, dynamic>{
      "url": url,
    };
    await db
        .collection('${FirebaseAuth.instance.currentUser!.uid}photo')
        .add(user)
        .then((DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'));
            
  }

  Future<List<PhotoData>> getphoto() async {
    FirebaseFirestore firebaseFirestore=await FirebaseFirestore.instance;
    List<PhotoData> diary = [];
    await firebaseFirestore
        .collection('${FirebaseAuth.instance.currentUser!.uid}photo')
        .get()
        .then(
      (querySnapshot) {
        print(querySnapshot.docs);
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          if (querySnapshot.docs.isNotEmpty) {
            diary.add(PhotoData.fromFirestore(docSnapshot));
          }
          
        }
      },
      onError: (e) => print("Error completing: $e"),
    );

    return diary;
  }
}
