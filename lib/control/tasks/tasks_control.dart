import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_day/model/modeltasks.dart';
import 'package:my_day/view/homescreen.dart';

TaskControl taskControl = TaskControl();

class TaskControl {
  Future<List<TaskData>> getdata() async {
    List<TaskData> diary = [];
    await db
        .collection('${FirebaseAuth.instance.currentUser!.uid}tasks')
        .get()
        .then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          diary.add(TaskData.fromFirestore(docSnapshot));
        }
      },
      onError: (e) => print("Error completing: $e"),
    );

    return diary;
  }

  adddata(TaskData model) async {
    final user = <String, dynamic>{
      "content": model.content,
    };
    await db
        .collection('${FirebaseAuth.instance.currentUser!.uid}tasks')
        .add(user)
        .then((DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  deletdada(doc, context) async {
    await db
        .collection('${FirebaseAuth.instance.currentUser!.uid}tasks')
        .doc(doc)
        .delete()
        .then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(
            title: 'My Day',
          ),
        ),
        (Route<dynamic> route) => false);
  }
}
