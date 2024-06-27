import 'package:flutter/material.dart';

class ContentDairy extends StatelessWidget {
  final String content;
  const ContentDairy({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Card(child: Text(content,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),),),
    );
  }
}