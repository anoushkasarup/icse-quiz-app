import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import './questions.dart';
import './o_button.dart';

class QuizPage extends StatefulWidget {

  final String subjectHolder;
  final Function functionHolder;

  const QuizPage(this.subjectHolder, this.functionHolder, {Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  String subject = 'Biology';
  var buttonHandler;

  @override
  void initState(){
    subject = widget.subjectHolder;
    buttonHandler = widget.functionHolder;   
    super.initState();
  }

  Stream<List<Question>> readQuestions() => 
  FirebaseFirestore.instance.collection(subject).snapshots()
  .map((snapshot) => snapshot.docs.map((doc) => Question.fromJson(doc.data())).toList());

  var currentIndex = 0;
  var rightAnswerCount = 0; 
  var wrongAnswerCount = 0; 

  reset(){
    setState(() {
      rightAnswerCount = 0;
      wrongAnswerCount = 0;
      currentIndex = 0;
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        leading: IconButton(
            onPressed: () => buttonHandler(),
            icon: BackButtonIcon(),
            tooltip: "Return to homepage",
          ),
        title: Text(subject),
      ),
      backgroundColor: Colors.pinkAccent,
      body: StreamBuilder<List<Question>>(
        stream: readQuestions(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final questions = snapshot.data!;
            if (currentIndex < questions.length){
              Question selected_q = questions[currentIndex];
              validateAnswer(userInput){
                setState((){
                  if(userInput == selected_q.answer){
                    rightAnswerCount += 1;
                  }
                  else{
                    wrongAnswerCount += 1; 
                  }
                  currentIndex += 1;
                });
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Answered right: $rightAnswerCount",
                        style: TextStyle(color: Colors.pink[50], 
                        fontSize: 13, fontWeight: FontWeight.bold)),
                        Text("Answered wrong: $wrongAnswerCount",
                        style: TextStyle(color: Colors.pink[50], 
                        fontSize: 13, fontWeight: FontWeight.bold))
                      ]
                    ),
                  ),
                  Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: Text("${currentIndex+1}. ${questions[currentIndex].question}", 
                          style: TextStyle(color: Colors.white, fontSize: 22),
                          textAlign: TextAlign.center),
                        ),
                        SizedBox(height: 25),
                        OptionButton(selected_q.option_a, validateAnswer),
                        OptionButton(selected_q.option_b, validateAnswer),
                        OptionButton(selected_q.option_c, validateAnswer),
                        TextButton(
                          onPressed: () => reset(),
                           child: Text("Reset",
                           style: TextStyle(color: Colors.pink[50], fontSize: 15))
                        )
                      ]
                      ),
                  ),
                  SizedBox(height: 60)
                ],
              );
            }
            else{
              return AlertDialog(
                title: Text("Results"),
                content: Text(
                  "Number of questions answered correct: $rightAnswerCount\nNumber of questions answered wrong: $wrongAnswerCount\n\nFinal score: ${((rightAnswerCount/questions.length)*100).toStringAsFixed(1)}%"),
                actions: [
                  TextButton(onPressed: () => reset(), child: Text("TRY AGAIN")),
                  TextButton(onPressed: () => buttonHandler(), child: Text("QUIT"))
                ]
              );
            }
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
        }),
    );
  }
}

