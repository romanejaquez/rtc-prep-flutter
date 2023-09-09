import 'package:flutter_rtc_prep/enums.dart';
import 'package:flutter_rtc_prep/models/question_option.model.dart';

class ExamQuestion {

  final String title;
  final String imagePath;
  final String notes;
  final String supportiveInfo;
  final ExamQuestionOptionType optionType;
  final List<QuestionOption> options;
  final bool currentQuestion;

  ExamQuestion({
    required this.title,
    required this.imagePath,
    required this.notes,
    required this.supportiveInfo,
    required this.optionType,
    required this.options,
    this.currentQuestion = false,
  });

  ExamQuestion copyWith({
    String? title,
    String? imgPath,
    String? notes,
    String? supportiveInfo,
    ExamQuestionOptionType? optionType,
    List<QuestionOption>? options,
    bool? currentQuestion,
  }) {
    return ExamQuestion(
      title: title ?? this.title, 
      imagePath: imagePath ?? this.imagePath, 
      notes: notes ?? this.notes, 
      supportiveInfo: supportiveInfo ?? this.supportiveInfo, 
      optionType: optionType ?? this.optionType, 
      options: options ?? this.options,
      currentQuestion: currentQuestion ??  this.currentQuestion
    );
  }

  factory ExamQuestion.fromJson(Map<String, dynamic> json) {
    return ExamQuestion(
      title: json['title'], 
      imagePath: json['imagePath'], 
      notes: json['notes'], 
      supportiveInfo: json['supportiveInfo'], 
      optionType: ExamQuestionOptionType.values.firstWhere((element) => element.name == json['optionType']), 
      options: getQuestionOptions(json['options'] as List<dynamic>),
    );
  }

  static ExamQuestion empty() {
    return ExamQuestion(
      title: '', 
      imagePath: '', 
      notes: '', 
      supportiveInfo: '', 
      optionType: ExamQuestionOptionType.none, 
      options: []
    );
  }

  static List<QuestionOption> getQuestionOptions(List<dynamic> options) {

    options.shuffle();
    const optionLabels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return [
      for(final (i,o) in options.indexed)
        QuestionOption.fromJson(optionLabels[i], o as Map<String, dynamic>)
    ];
  }
}