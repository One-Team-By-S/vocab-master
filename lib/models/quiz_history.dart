import 'package:hive/hive.dart';

import '../services/hive_helper/adapter.dart';
part 'quiz_history.g.dart';

@HiveType(typeId: 29, adapterName: HiveAdapters.quizhistory)
class QuizHistory {
  @HiveField(0)
  final String quiz;

  @HiveField(1)
  final int totalQuestions;

  @HiveField(2)
  final String answer1;

  @HiveField(3)
  final String answer2;

  @HiveField(4)
  final String answer3;
  @HiveField(5)
  final String answer4;

  QuizHistory({
    required this.quiz,
    required this.totalQuestions,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
  });
}
