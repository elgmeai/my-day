import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_day/model/modeldiary.dart';
import 'package:my_day/view/homescreen.dart';

class DairyControl {
  

  Future<List<DiaryData>> getdata() async {
    List<DiaryData> diary = [];
   await db.collection('${FirebaseAuth.instance.currentUser!.uid}diary').get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          diary.add(DiaryData.fromFirestore(docSnapshot));
                  }
      },
      onError: (e) => print("Error completing: $e"),
    );
    
    return diary;
  }

  adddata(DiaryData model)async {
    final user = <String, dynamic>{
      "title": model.title,
      "content": model.content,
    };
await
    db
        .collection('${FirebaseAuth.instance.currentUser!.uid}diary')
        .add(user)
        .then((DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'));
  }
  deletdada(doc,context)async{
   await db.collection('${FirebaseAuth.instance.currentUser!.uid}diary').doc(doc).delete().then(
      (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: 'my app',),),(Route<dynamic> route) => false);
  }
    updatedata(DiaryData model)async {
    final user = <String, dynamic>{
      "title": model.title,
      "content": model.content,
    };
final washingtonRef = db.collection('${FirebaseAuth.instance.currentUser!.uid}diary').doc(model.id);
washingtonRef.update(user).then(
    (value) => print("DocumentSnapshot successfully updated!"),
    onError: (e) => print("Error updating document $e"));

}
}