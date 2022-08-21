import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {

  final String selected_option;
  final Function optionHandler;

  const OptionButton(this.selected_option, this.optionHandler, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          child: Text(selected_option,
          style: TextStyle(color: Colors.black, fontSize: 16)),
          onPressed: () => optionHandler(selected_option),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            elevation: 0
          )
        )
      ),
      SizedBox(height: 10)
    ]);
  }
}