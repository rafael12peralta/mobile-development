class Quiz {
  String question;
  List<String> answers;

  Quiz({required this.question, required this.answers});

  List<String> getShuffledAnswers() {
    final shuffleList = List.of(answers);
    shuffleList.shuffle();
    return shuffleList;
  }
}
