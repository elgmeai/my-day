import 'package:cloud_firestore/cloud_firestore.dart';

class TaskData {
  
   final String content;
   String? id;

  TaskData({
      
     required this.content,
      this.id
  });

  factory TaskData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    
  ) {
    final data = snapshot.data();
    return TaskData(
      id: snapshot.id,
     
      content: data?['content'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      
      "content": content,
    };
  }
}