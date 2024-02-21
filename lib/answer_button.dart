// this file is for storing elevatedButton for answers
import 'package:flutter/material.dart';

// it's a statelesswidget because i have no state that would need to be managed inside the button
class AnswerButton extends StatelessWidget {
  const AnswerButton({
    // named arguments are optional so you need to add required
    super.key,
    required this.answerText,
    required this.onTap,
  });

  final String answerText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        // padding is for adjusting space between text and button
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        backgroundColor: const Color.fromARGB(255, 184, 32, 169),
        // foregroundColor is for chaning text color
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      // this is for displaying the text in the button
      // anaswerText is a String as defined in the constructor function
      // AnswerButton() takes answerText and onTap as its argument
      // in questions_screen.dart, answer variable is passed to answerText argument
      child: Text(
        answerText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
