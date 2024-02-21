import 'package:adve_basics/questions_summary/summary_item.dart';
import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  // this.summaryData should be a positional argument
  // because getSummaryData() will be executed in results_screen.dart and a named argument requires an argument that exactly matches it
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    // SizeBox() is used for adding a fixed height
    return SizedBox(
      height: 400,
      // If height iin SizedBox is not enough to contain the content, the content is overflown
      // SingleChildScrollViee() is used for addressing it
      // It makes its child scrollable
      child: SingleChildScrollView(
        child: Column(
          // Column children wants a list of Widgets, but summaryData is a list of maps
          // map function has nothing to do with Map data type
          // map in map function means that we map a value to a new value\
          // You need to pass your function to this map method
          // This map method receives a function as an argument
          // Then you want to return a widget that a piece of data in data should be mapped
          // map function returns Iterable<T> (iterable object), which is almost the same as a List
          // So you need to convert the iterable object to a List
          // When you add Text(data['question_index'] + 1, Dart does not know which value will be stored under the question_index key (i.e., Dart doesn't know if question_index is a number)
          // because Object in List<Map<String, Object>> summary = []; means the List of map accepts any kinds of value as a value
          // So, you have to do type casting
          // Using as keyword, you can tell Dart which value data['question_index'] will be
          // However, you cannot pass int to Text() because it accepts String
          // So you need to convert int to String
          children: summaryData.map(
            (data) {
              return SummaryItem(data);
            },
          ).toList(),
        ),
      ),
    );
  }
}
