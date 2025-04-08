import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:vocab_master/models/quiz_history.dart';
import 'package:vocab_master/services/hive_helper/hive_names.dart';
import 'package:vocab_master/widgets/custom_progressbar.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? selectedIndex;
  bool isAnswered = false;
  bool isLoading = false;
  String? question;
  String? correctAnswer;
  List<String> options = [];
  final String apiKey = "AIzaSyCLRcquQ5WU7PjCWDZqd3ttS7Lx0zUzYuk";

  // Keep track of used words
  final Set<String> usedWords = {};
  int result = 0;
  @override
  void initState() {
    super.initState();
    fetchQuestion();
  }

  double _progress = 0;
  void _increaseProgress() {
    setState(() {
      _progress += 0.1;
      if (_progress >= 1.0) {
        _progress = 1.0;
      }
    });
  }

  Future<void> fetchQuestion() async {
    setState(() {
      isLoading = true;
    });

    final model = GenerativeModel(model: "gemini-1.5-flash", apiKey: apiKey);

    try {
      final response = await model.generateContent([
        Content.text(
          // Modified prompt to exclude previously used words
          "Provide an English word, its correct Uzbek translation, and 3 incorrect Uzbek translations in this exact format: 'word: [word], translation: [correct], options: [wrong1, wrong2, wrong3, correct]'. Make correct and incorrect options random. Do not consider any spelling errors in the words or translations. If a word has multiple variations (e.g. 'computer', 'kumpyuter', 'kompyuter'), treat them as equivalent and do not consider their spelling differences. Exclude these words: ${usedWords.join(', ')}"
      
        ),
      ]);

      final text = response.text ?? "";
      print("API response: $text");

      RegExp regex = RegExp(
        r"word: (.*?), translation: (.*?), options: \[(.*?)]",
      );
      var match = regex.firstMatch(text);

      if (match != null) {
        setState(() {
          question = match.group(1);
          correctAnswer = match.group(2);
          options = match.group(3)!.split(", ");
          options.shuffle();
          selectedIndex = null;
          isAnswered = false;
          isLoading = false; // Hide loader when data is received
          if (question != null) {
            usedWords.add(question!); // Add new word to used words set
            QuizHistory allQuiz = QuizHistory(
              quiz: question ?? "empty",
              answer1: correctAnswer ?? "answer1",
              totalQuestions: 10,
              answer2: options[0],
              answer3: options[1],
              answer4: options[2],
            );
            HiveBoxes.quizhistory.add(allQuiz);
          }
        });
      } else {
        print("Error: API response format is incorrect.");
        setState(() {
          question = "Error";
          correctAnswer = "Try again";
          options = ["Something went wrong"];
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching question: $e");
      setState(() {
        question = "Error";
        correctAnswer = "Try again";
        options = ["Something went wrong"];
        isLoading = false;
      });
    }
  }

  void checkAnswer(int index) {
    if (!isAnswered) {
      setState(() {
        selectedIndex = index;
        isAnswered = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  CustomProgressbar(progress: _progress),
                  const Spacer(),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    transform: Matrix4.translationValues(
                      0,
                      isAnswered ? -20 : 0,
                      0,
                    ),
                    child: Text(
                      question?.toUpperCase() ?? '',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 40),
                  if (options.isNotEmpty)
                    ...List.generate(options.length, (index) {
                      bool isCorrect = options[index] == correctAnswer;
                      bool isSelected = index == selectedIndex;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: GestureDetector(
                          onTap: () {
                            if (!isAnswered) {
                              _increaseProgress();
                              checkAnswer(index);
                              if (isCorrect == true) {
                                result += 1;
                                print(result);
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 24,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? (isCorrect
                                          ? const Color(0xFF34D399)
                                          : const Color(0xFFEF4444))
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color:
                                    isSelected
                                        ? Colors.transparent
                                        : Colors.grey.shade300,
                                width: 2,
                              ),
                              boxShadow:
                                  isSelected
                                      ? const [
                                        BoxShadow(
                                          color: Color(0x1F000000),
                                          blurRadius: 10,
                                          offset: Offset(0, 4),
                                        ),
                                      ]
                                      : const [],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    options[index],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : const Color(0xFF4B5563),
                                    ),
                                  ),
                                ),
                                if (isAnswered)
                                  Icon(
                                    isCorrect ? Icons.check_circle : Icons.cancel,
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : isCorrect
                                            ? const Color(0xFF34D399)
                                            : const Color(0xFFEF4444),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                  const Spacer(),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    transform: Matrix4.translationValues(
                      0,
                      isAnswered ? 0 : 20,
                      0,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        isLoading ? null : fetchQuestion();
                        if (_progress >= 0.9) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.bottomSlide,
                            title: 'Congratulations you finished',
                            desc: 'You solved $result question correctly from 10 questions',
                            btnCancelOnPress: () {
                              Navigator.pop(context);
                            },
                            btnOkOnPress: () {
                              result = 0;
                              _progress = 0;
                              setState(() {});
                            },
                          ).show();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isAnswered ? "Next Question" : "Skip Question",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (isLoading)
                            const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 3,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Generating Question...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
