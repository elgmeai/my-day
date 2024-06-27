import 'package:cloud_firestore/cloud_firestore.dart';

class PhotoData {
  final String url ;
  final String? id;

  PhotoData({ required this.url, this.id});

  factory PhotoData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    
  
    final data = snapshot.data();
    return PhotoData(
      id: snapshot.id,
      url: data?["url"]
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      
      "url": url,
    };
  }
  
}
