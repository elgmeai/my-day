import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_day/view/dairy/My_diary.dart';
import 'package:my_day/view/my_photo/my_photo.dart';
import 'package:my_day/view/tasks/my_tasks.dart';

var db = FirebaseFirestore.instance;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool a = true;
  @override
  void initState() {
    super.initState();

    diaryControl.getdata();
    taskControl.getdata();
    photoControl.getphoto();
   // photoControl.getphoto();
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    MyDiary(),
    MyTasks(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    MyPhoto()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[400],
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.teal[200],
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book_rounded,
            ),
            label: 'Diary',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.task,
            ),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.alarm,
            ),
            label: 'Alarm',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.image,
            ),
            label: 'photo',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class my_photo extends StatelessWidget {
  const my_photo({
    super.key,
    required this.optionStyle,
  });

  final TextStyle optionStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Index 0: Home',
      style: optionStyle,
    );
  }
}
