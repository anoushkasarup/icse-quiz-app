import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import './page.dart';
import './s_button.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List subjects = ["Biology", "Chemistry", "Physics", "History", "Geography"];

  bool PageIndex = true; 

  String selected_subject = "";

  homePage(){
    setState((){
      PageIndex = true;
    }  
    );
  }

  void changePage(s) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        selected_subject = s;
        PageIndex = false;
      });
    });
  } 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.pink[50],
        body: PageIndex ? Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("ICSE Quiz App", style: TextStyle(fontSize: 30)),
              SizedBox(height: 30),
              Text("Select a subject", style: TextStyle(fontSize: 20)), 
              SizedBox(height: 40),
              ...subjects.map((sub){
                return SubjectButton(pageHandler: changePage, subject: sub);
              }).toList()
            ]
          ),
        ) 
        : QuizPage(selected_subject, homePage) 
      )
    );
  }
}

