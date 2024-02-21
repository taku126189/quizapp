// QuestionsScreen.dart walks user through questions and lets the user pick answers
// It depends on "which screen is visible" state
// StartScreen should switch to QuestionsScreen once the "Start Quiz" button was pressed
// Two widgets (StartScreen and QuestionsScreen) need to use the same state
// The parent widget here is quiz.dart
// the child widgets are StartScreen and QuestionsScreen

import 'package:adve_basics/answer_button.dart';
import 'package:flutter/material.dart';
import 'package:adve_basics/data/questions.dart';
// import GoogleFonts
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.onSelectAnswer,
  });

// You need to add onSelectAnswer variable for QuestionsScreen to accept chooseAnswer as a value in quiz.dart
// onXYZ means it is triggered upon a certain event
// onSelectAnswer was created in QuestionsScreen widget class, but it actually needed in the state class
// because WuestionsScreen widget is a StatefulWidget and it is split out into two classes
// which means that you need to get hold of the property that belongs to the widget class inside of this state class
  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
// you need to change the element of final currentQuestion = questions[0];
// so create a new variable currentQuestionIndex here
// initially it shouls be 0
// every time an answer is pressed, currentQuestionIndex should be changed
  var currentQuestionIndex = 0;

// you need to show the result screen after the app runs out of the questions
// thus, quiz.dart that navigates which screen is displayed is important

// answerQuestion function is executed when the answer button is pressed
  void answerQuestion(String selectedAnswer) {
    // widget property can be build in the state class
    // It gives you access to the widget class above and its properties (i.e., onSelectAnswer)
    // You need to pass an answer to this property (method)
    // So, you need to find out what the selected answer is
    // So, answerQuestion() also should accept the selected answer (i.e., String selectedAnswer)
    // Then, selectedAnswer variable can be passed to onSelectAnswer
    // chooseAnswer function in quiz.dart ->
    // onSelectAnswer argument in QuestionsScreen widget ->
    // executed inside answerQuestions function ->
    // used as a value for onPressed
    // Now, answerQuestions takes an argument selectedAnswer
    // But, AnswerButton(onTap: ) does not want an argument
    widget.onSelectAnswer(selectedAnswer);
    // in order for the build method to be executed again so currentQuestionIndex increments,
    // you need to add setState()
    setState(() {
      // the right side of currentQuestionIndex will be executed first
      // then Dart takes the value that's currently stored in the currentQuestionIndex, which is initially zero
      // then add one to it, so the new value is stored into the left side of currentQuestionIndex variable
      // currentQuestionIndex = currentQuestionIndex + 1;
      // currentQuestionIndex += 1;
      // This increments the value by 1
      // Now, you can include currentQuestionIndex into final currentQuestion = questions[0];
      // So, you need to replace answerQuestion with an anonymous function () {}
      // onTap: () {answerQuestion(answer);},
      // the function body (i.e., answerQuestion) will be executed only when the anonymous question is triggered
      // so it will not be executed immediately,
      // rather it will be executed when the button is tapped
      // the answer button is tapped -> the answer of the button that was tapped will be passed as a value to answerQuestion function
      // -> forward the value to onSelectAnswer variable, which is in the parent widget, through widget.onSelectAnswer(selectedAnswer)
      // because the parent widget receives onSelectAnswer as an argument
      // Then, in quiz.dart, QuestionsScreen(onSelectAnswer: chooseAnswer), executes chooseAnswer function
      // onTap: answerQuestion,
      // If you code like this, answerQuestion, which is forwarded as a value to onTap, will be executed immediately when AnswerButton is executed (i.e., when AnswerButton is created)
      //
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(context) {
    // questions variable is a List of String that takes text and answers
    // A new variable currentQuestion is created for using the variable in this class and displaying question and answers
    // questions are objects
    // you can access data stored in objects by using the dot notation
    // Adding the dot notation after a variable that contains the object
    // allows you to access the available data properties and methods defined in the class blueprint of that object
    // currentQuestion.text allows you to access 'text'
    final currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      // double.infinity used as much width as possib le and you can use it as a value
      width: double.infinity,
      child: Container(
        // EdgeInsets.all adds the same margin to top, bottom, left, and right
        margin: const EdgeInsets.all(40),
        child: Column(
          // The main axis for Column is the vertical axis so the cross axis for Column is the horizontal axis
          // CrossAxisAlignment.stretch fills out the space so it widens as much as it can
          // Padding = space between widget content (e.g., text) and border
          // Margin = space between widgets
          // You need to refactor Column() Widget with Container() Widget because the margin argument is included in it
          crossAxisAlignment: CrossAxisAlignment.stretch,

          // MainAxisAlignment.center allows you to place an object in centre
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentQuestion.text,
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              // style: const TextStyle(
              //   color: Colors.white,
              //   fontSize: 20,
              // textAlign arugment centerise the text
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Here map allows you to convert a List of Strings into a lit of tappable answer button widgets
            // converting a List of String into Widgets that use these Strings
            // This can be done by map method which allows you to convert the values in a list to other values
            // When it comes to a List, Dart has a lot of built-in methods that can be called on a List
            // map takes Funtions as a value
            // the function that you pass to map is executed for every list item
            // map ((XYZ) {})
            // After Dart executed the function to every list item,
            // Dart will automatically pass the list item as an argument to this function
            // XYZ is an arugment for the function being executed
            // Inside the function body ({}), you can return the transformed item
            // This conversion does not change the original list
            // Rather, it creates a new List that has new values
            // Column(children: ) children takes a List of Widgets
            // However, now we're creating another list (nested list), currentQuestion.answers.map((answer) {return AnswerButton(answerText: answer, onTap: () {});},)
            // So, we have to do spreating
            // We have to spread this list or this iterable into a couple of individual values
            // To allow this, you need to add ...
            // ... pulls values in the list out of the list/iterable,
            // and places them as comma-separated values
            // Now, you can remove all AnswerButton()
            // because ... pulls out all values in the list and adds them into children as an individual value
            // Now, the answers are dynamically generated instead of being hardcoded
            // shuffle() is a built-in method that can be called on a List to change the order of list items
            // however, unlike map(), it changes the original list
            // so you need to create a copy of the original list that will be shuflled
            // adding getShuffledAnswers() which you created
            ...currentQuestion.getShuffledAnswers().map(
              (answer) {
                // pass answerQuestion Function as a value and as a pointer to onTap argument,
                // so you do not need to include ()
                return AnswerButton(
                  answerText: answer,
                  onTap: () {
                    answerQuestion(answer);
                  },
                );
              },
            ),
            // AnswerButtons are hardcoded now so it is better to avoid it
            // AnswerButton(
            //   answerText: currentQuestion.answers[0],
            //   onTap: () {},
            // ),
            // AnswerButton(
            //   answerText: currentQuestion.answers[1],
            //   onTap: () {},
            // ),
            // AnswerButton(
            //   answerText: currentQuestion.answers[2],
            //   onTap: () {},
            // ),
            // AnswerButton(
            //   answerText: currentQuestion.answers[3],
            //   onTap: () {},
            // ),
          ],
        ),
      ),
    );
  }
}
