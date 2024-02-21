// StartScreen.dart welcomes user and provides 'Start Quiz' button
// It changes state that controls which screen is visible
// It should switch to QuestionsScreen once the "Start Quiz" button was pressed
// The parent widget here is quiz.dart
// the child widgets are StartScreen and QuestionsScreen

import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  // add a positional argument which is this.startQuiz
  const StartScreen(this.startQuiz, {super.key});

  // startQuiz is a fucntion that contains a function as its value
  // after adding this.startQuiz and creating the variable below,
  // you can use startQuiz as a variable in this class
  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    // you need to wrap up with Center widget
    // Center widget places a widget inside child parameter in the centre of the screen
    // thus, it takes as much space as it can
    // since there is no other widget that takes space in Container() in main.dart,
    // using Center widget allows you to set color in the background
    return Center(
      child: Column(
        // this takes mimimum space available
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            '/Users/takuyasaka/flutterprojects/adve_basics/assets/images/quiz-logo.png',
            width: 300,
            // adding color named parameter is a better way to add transparancy to an image
            color: const Color.fromARGB(95, 249, 247, 247),
          ),

          // Opacity is performance intensive. You should avoid it whenever you can
          // Opacity(
          //   opacity: 0.1,
          //   child: Image.asset(
          //     '/Users/takuyasaka/flutterprojects/adve_basics/assets/images/quiz-logo.png',
          //     width: 300,
          //   ),
          // ),
          // SizedBox takes space that you specified
          const SizedBox(height: 80),
          const Text(
            'Learn Flutter the fun way!',
            style: TextStyle(
              fontSize: 20.5,
              color: Color.fromARGB(255, 239, 240, 242),
            ),
          ),
          const SizedBox(height: 80),
          // .icon (icon connstructor function) adds an icon button
          // if you add .icon, child must be replaced with the named parameter, label
          OutlinedButton.icon(
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text('Start'),
          )
        ],
      ),
    );
  }
}
