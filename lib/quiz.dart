// Every Flutter Widget has a built-in lifecycle:
// A collection of methods that are automatically executed by Flutter (at certain points of time)
// There are three extremely important (stateful) widget lifecycle methods you should be aware of:
// initState(): Executed by Flutter when the StatefulWidget's State object is initialized
// build(): Executed by Flutter when the Widget is built for the first time AND after setState() was called
// dispose(): Executed by Flutter right before the Widget will be deleted (e.g., because it was displayed conditionally)
// You will encounter them all multiple times throughout the course - therefore you don't have to memorize them now and you will see them in action. It's still worth learning about them right now already.

import 'package:adve_basics/data/questions.dart';
import 'package:adve_basics/questions_screen.dart';
import 'package:adve_basics/results_screen.dart';
import 'package:adve_basics/start_screen.dart';
import 'package:flutter/matrial.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

// By adding an underscore in front of a class name,
// you tell Dart that this class is meant to be private
// So, it should be only usable inside of this file
// To put it another way, if you put ver quizState = _QuizState();, the error occurs
// You can make variables private by adding an underscore at the beginning 
class _QuizState extends State<Quiz> {
  // selectedAnswers stores a List of answers the user chose
  // I don't plan on reassigning this variable so add final
  List<String> selectedAnswers = [];

  // storing a widget in a variable
  // you can do this because widgets are objects and objects are values in Dart
  // when the build method is executed for the first time, the value of StartScreen is set to activeScreen
  // when switchScreen is executed and then the build method is re-executed, the value of QuestionsScreen is set to activeScreen
  // in this way, you can render content conditionally
  // The parent widget here is quiz.dart
  // the child widgets are StartScreen and QuestionsScreen
  // Lifting the state up so that the parent widget is a state and can manipulate it
  // This allows you to render content conditionally and move between two widgets
  // StartScreen needs to get access to switchScreen function
  // include switchScreen. If you include () together, the function will be executed, which is too early
  // Both the variable and method creation happens at the same point of time when the class is instantiated (when the class turned into an object)
  // Widget activeScreen =  StartScreen(switchScreen); and
  // void switchScreen() {setState(() {activeScreen = const QuestionsScreen();});}
  // Therfore, Widget activeScreen =  StartScreen(switchScreen); is too early because switchScreen has not exisited yet
  // So, you need to add initState method
  // Widget activeScreen =  StartScreen(switchScreen);
  // activeScreen can technically be null at the beginning after the object was created
  // so add ?
  // Widget? activeScreen;

  // there is another way without using initState
  // var activeScreen = 'start-screen'
  // void switchScreen() {
  // setState(() {
  // activeScreen = 'questions-screen';
  // }
  // )
  // }
  // Widget build(BuildContext context) {......
  // child: activeScreen == 'start-screen' ? StartScreen(switchScreen) : const QuestionsScreen(),
  // This is called ternary expression in Dart,
  // which yileds one value if the condition is met,
  // and yields another value if the condition is not met

  var activeScreen = 'start-screen';

  // initState is a method provided by this State class
  // but we can override it to add our own initialization logic
  // this is used when the state object is created for the first time
  // initState executes only once
  // @override
  // void initState() {
  //   // all variables and methods will have been initialized and created
  //   activeScreen = StartScreen(switchScreen);
  //   // super.initState(); makes sure in the parent class, initState is
  //   super.initState();
  // }

  void switchScreen() {
    // setState will re-execute the build method
    // then if there's any difference between the result of execution this time and the one last time,
    // it updates the rendered UI
    setState(() {
      // if switchScreen is executed, the value of activeScreen would be overridden
      // however, this causes an error that says a value of type QuestionsScreen can't be assigned to a variable of type StartScreen
      // because activeScreen if of type StartScreen in var activeScreen = const StartScreen();
      // When a class is created, the class automatically has a type of the class's name like StartScreen
      // If the class's type is its name, it is very specific and less flexible
      // so in order for activeScreen to accept all widgets, replace var with Widget
      // i.e., Widget activeScreen = const StartScreen();
      // activeScreen = const QuestionsScreen();

      activeScreen = 'questions-screen';
    });
  }

  // This method is expected to get String answer
  // Inside the function body, it updates selectedAnswers variable
  // You need to pass chooseAnswer as a pointer and as a value to QuestionsScreen()
  void chooseAnswer(String answer) {
    // add() is a built-in method that can be called on a List
    // It adds an item to the list
    // It does not reassign the variable, so final can be added in final List<String> selectedAnswers = [];
    selectedAnswers.add(answer);

    // You need to make sure after the questions run out, the error screen does not pop up
    // So, you need to add a condition that can tell until which point the screen should show the questions
    // You need to add setState() to reexecuted the build method (i.e., to switch the screen shown)
    // If you add activeScreen = 'start-screen'; in setState, the second time you finish the questions, the error screen is shown
    // because the condition in this if statement, which is selectedAnswers.length == questions.length is no longer met
    // So you need to work around that by having selectedAnswers back to be an empty list
    // So you need to remove final from final List<String> selectedAnswers = [];
    // Then you need to add selectedAnswers = []; in this setState
    if (selectedAnswers.length == questions.length) {
      setState(() {
        // selectedAnswers = [];
        activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      activeScreen = 'start-screen';
      selectedAnswers = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    // this variable is only available within the build method
    // you can include the variable below within the build method,
    // and then put screenWidget to child:
    // final screenWidget = activeScreen == 'start-screen'
    //     ? StartScreen(switchScreen)
    //     : const QuestionsScreen();

    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'questions-screen') {
      // You need to pass chooseAnswer as a pointer and as a value to QuestionsScreen()
      // So in QuestionsScreen, it must accept chooseAnswer as a value
      // So you need to add a new variable onSelectAnswer and add the argument here
      screenWidget = QuestionsScreen(
        onSelectAnswer: chooseAnswer,
      );
    }

    if (activeScreen == 'results-screen') {
      // ResultsScreen needs to accept selectedAnswers as a value for counting how many answers the user got right
      // So you need to create a new variable chosenAnswers in ResultsScreen
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswers,
        onStart: restartQuiz,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(26, 39, 222, 1),
                Color.fromARGB(66, 107, 6, 215),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
