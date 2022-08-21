import 'package:flutter/material.dart';

class SubjectButton extends StatelessWidget {

  final Function pageHandler;
  final String subject;

  const SubjectButton({Key? key, required this.pageHandler, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120, 
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.pink,
              elevation: 5, 
            ),
            onPressed: () => pageHandler(subject),
            child: Text(subject, style: TextStyle(fontSize: 17)) 
          )
        ),
        SizedBox(height: 20)
      ],
    );
  }
}