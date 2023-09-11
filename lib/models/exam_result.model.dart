class ExamResult {

  final double score;
  final int wrongQuestions;
  final int correctQuestions;
  final bool passed;

  ExamResult({
    required this.score,
    required this.wrongQuestions,
    required this.correctQuestions,
    required this.passed,
  });
}