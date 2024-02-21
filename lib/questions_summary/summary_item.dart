// The error occured saying The error occurs due to a type mismatch during a type cast operation. Specifically, the code is attempting to cast a value to an int, but the value is null, resulting in the type error
// The error occurs due to a type mismatch during a type cast operation. Specifically, the code is attempting to cast a value to an int, but the value is null, resulting in the type error.
// casting refers to the process of converting a value from one data type to another.
// You mistyped 'correct_answer' as 'correct-answer' and 'question_index' as 'question-index'
// Since you mistyped them, they do not exist in the itemData map.
// Therefore, attempting to access them returns null.
// When comparing these null values to other values, such as integers (int), during the comparison operation, a type mismatch occurs, resulting in the error message you encountered.
// i.e., questionIndex: itemData['question_index'] as int,
// Lesson Learned:
// Typos or inconsistencies in key names can lead to runtime errors, such as type mismatches, when accessing values from maps

import 'package:adve_basics/questions_summary/question_identifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(this.itemData, {super.key});

// one summary data row
  final Map<String, Object> itemData;

  @override
  Widget build(BuildContext context) {
    final isCorrectAnswer =
        itemData['user_answer'] == itemData['correct_answer'];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionIdentifier(
          questionIndex: itemData['question_index'] as int,
          isCorrectAnswer: isCorrectAnswer,
        ),
        const SizedBox(width: 20),

        // Without Expanded(), Column() takes an infinite amount of width, even if that goes beyond the screen boundaries
        // Expanded allows its child to take the available space along the flex widget's main axis
        // The flex widget is a Row or Column widget above the widget that you put into Expanded (i.e., Row())
        // The maximum Width of the Row widget is the maximum width of the screen
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemData['question'] as String,
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                itemData['user_answer'] as String,
                style: GoogleFonts.lato(
                  color: Colors.blue,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                itemData['correct_answer'] as String,
                style: GoogleFonts.lato(
                  color: Colors.red,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
