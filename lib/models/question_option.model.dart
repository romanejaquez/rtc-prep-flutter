class QuestionOption {

  final String title;
  final bool correct;
  final bool isSelected;
  final String optionLetter;

  QuestionOption({
    required this.title,
    required this.correct,
    this.isSelected = false,
    this.optionLetter = '',
  });

  factory QuestionOption.fromJson(String letter, Map<String, dynamic> json) {
    return QuestionOption(
      title: json['title'],
      correct: json['correct'],
      optionLetter: letter
    );
  }

  QuestionOption copyWith({
    String? title,
    bool? correct,
    bool? isSelected
  }) {
    return QuestionOption(
      title: title ?? this.title, 
      correct: correct ?? this.correct,
      isSelected: isSelected ?? this.isSelected,
      optionLetter: optionLetter,
    );
  }
}