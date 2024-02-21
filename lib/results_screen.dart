import 'package:adve_basics/data/questions.dart';
import 'package:adve_basics/questions_summary/questions_summary.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.onStart,
  });

  final void Function() onStart;

  final List<String> chosenAnswers;

  // getters
  // getSummaryData() {} takes no values and no parameters and it produces some data int the end based on some other class properties,
  // you could use a getter
  // get is a special keyword in Dart which creates a getter
  // getter is in the end a method because it has a function body {}
  // However, you don't call summaryData like a method
  // Instead, you simply refer to it as a variable (i.e., summaryData)
  // List<Map<String, Object>> get SummaryData {
  //   final List<Map<String, Object>> summary = [];
  //   for (var i = 0; i < chosenAnswers.length; i++) {
  //     summary.add(
  //       {
  //         'question_index': i,
  //         'question': questions[i].text,
  //         'correct_answer': questions[i].answers[0],
  //         'user_answer': chosenAnswers[i]
  //       },
  //     );
  //   }

  //   return summary;
  // }

  // In this function, i want to return a List of maps another similar set, using a particular method
  // Mapping means in English that connecting a set of values to another
  // You need to specify the data type of keys and values
  // As all values in Dart are objects, Object is a flexible data type so values here can be any data type
  // I want to populate the list
  // Populating means in English = to automatically add information to a list or table on a computer:
  // To do that, you use for loop, which is a control structure
  // if statement is one of control structures
  // for loop allows you to execute a certain code snippet multiple times
  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    // between (), you need to add for loop configuration
    // This configuration consists of three parts
    // The first part is a helper variable, which is typically i
    // It is set to its initial value
    // The second part is for defining how long the for loop lasts
    // The third part is for defining how i should change every after iteration
    // loop body is executed until the second part is no longer met
    // I want to add key value set of data to summary
    // summary.add({}); These {} mean that a value is expected, so create a map
    // {} can be used in places where a value is expected
    // {} is for creating a map value in Dart
    // Inside {}, you can set any key values as long as they are String in this case

    // question key is for adding actual question text to this summary object
    // correct_answer is for storing correct answers to this summary object
    // Correct answers are always the first one in questions.dart, so the set of questions was not allowed to get shuffled
    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswers[i]
        },
      );
    }

    return summary;
  }

  // arrow function
  // () {} means that () takes a value and {} immediately returns a value
  // e.g., where.((data)) {return XYZ}
  // In this case, you can use =>
  // e.g., where.((data)) => XYZ
  


  @override
  Widget build(BuildContext context) {
    // To derive correct answers, you need to compare correct_answer and user_answer that are stored in summary when getSummaryData() is executed
    //
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;

    // where method allows you to filter the list on which you are calling it
    // Like map function, where method does not change the original list, instead it returns a new list (iterable)
    // you have to pass a function to where, just like you did to map function
    // The function passed will be executed for every item in the list
    // You return true if the data point should be kept in the new filtered list that is returned by where
    // You return false if the data should be dropped from the new filtered list
    // .length is added to get the number of items kept in the new filtered list
    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
      // double.infinity used as much width as possib le and you can use it as a value
      width: double.infinity,
      child: Container(
          // EdgeInsets.all adds the same margin to top, bottom, left, and right
          margin: const EdgeInsets.all(40),
          child: Column(
              // MainAxisAlignment.center allows you to place an object in centre
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // getSummaryData() will be executed as a Function
                QuestionsSummary(summaryData),
                const SizedBox(
                  height: 30,
                ),
                FloatingActionButton.extended(
                  onPressed: onStart,
                  label: const Text('Restart Quiz'),
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  icon: const Icon(Icons.refresh),
                ),
                // TextButton(
                //   onPressed: () {},
                //   child: const Text('Restart Quiz'),
                // )
              ])),
    );
  }
}
