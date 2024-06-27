import 'package:cloud_firestore/cloud_firestore.dart';

class DiaryData {
   final String title;
   final String content;
   String? id;

  DiaryData({
      required this.title,
     required this.content,
      this.id
  });

  factory DiaryData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    
  ) {
    final data = snapshot.data();
    return DiaryData(
      id: snapshot.id,
      title: data?['title'],
      content: data?['content'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": title,
      "state": content,
    };
  }
}
