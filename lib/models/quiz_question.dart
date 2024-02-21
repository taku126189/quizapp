// you want to put all questions and answeres into one data structure
// so you need to create the file dedicated for the purpose
// This is a blueprint for questions
class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

// getShuffledAnswers() can be a getter
// because it takes another class property, answers
// and then derives some data based on that property
// List<String> get shuffledAnswers {}

  List<String> getShuffledAnswers() {
    // creating a copy of answers
    // List is not just a type, but a class
    // of constructor function created another list so it copies an existing list
    // calling shuffle() on the new list created here
    // so the old list (i.e., the original list) remains untouched and the new list will be shuffled
    // This is called chaining,
    // which means that calling a method on the result of calling another method
    // List.of(answers).shuffle();
    // shuffle() returns nothing (i.e., void function)
    // So you need to assign a variable to it and call shuffle() on it
    // final ensures that you cannot reassign the variable
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}
