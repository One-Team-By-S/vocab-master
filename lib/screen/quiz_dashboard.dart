import 'package:flutter/material.dart';
import 'package:vocab_master/models/quiz_history.dart';
import 'package:vocab_master/screen/quiz_screen.dart';
import 'package:vocab_master/services/hive_helper/hive_names.dart';
import 'package:vocab_master/widgets/build_quiz_info.dart';

class QuizDashboard extends StatefulWidget {
  const QuizDashboard({super.key});

  @override
  State<QuizDashboard> createState() => _QuizDashboardState();
}

class _QuizDashboardState extends State<QuizDashboard> {
  late List<QuizHistory> solvedQuiz;

  @override
  void initState() {
    super.initState();
    solvedQuiz = HiveBoxes.quizhistory.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuizScreen()),
            ),

        backgroundColor: Theme.of(context).primaryColor,
        child: const Text('Start', style: TextStyle(color: Colors.white)),
      ),

      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const QuizInfoWidget(),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "History of tests run",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              solvedQuiz.isEmpty
                  ? const Center(
                    child: Text(
                      "No tests have been run yet.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                  : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: solvedQuiz.length,
                    itemBuilder: (context, index) {
                      final quiz = solvedQuiz[index];
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Test name: ${quiz.quiz}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  _buildAnswerChip(quiz.answer1, true),
                                  _buildAnswerChip(quiz.answer2, false),
                                  _buildAnswerChip(quiz.answer3, false),
                                  _buildAnswerChip(quiz.answer4, false),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerChip(String answer, bool isCorrect) {
    return Chip(
      label: Text(answer),
      labelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: isCorrect ? Colors.green : Colors.redAccent,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}
