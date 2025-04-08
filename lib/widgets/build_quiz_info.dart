import 'package:flutter/material.dart';

class QuizInfoWidget extends StatefulWidget {
  const QuizInfoWidget({super.key});

  @override
  State<QuizInfoWidget> createState() => _QuizInfoWidgetState();
}

class _QuizInfoWidgetState extends State<QuizInfoWidget> {
  @override
  Widget build(BuildContext context) {

      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const SizedBox(height: 16),
            const Text(
              "Testlar",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Agar tayyor bo‘lsangiz "start" tugmasini bosing',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),

            // Info tiles (Qiyinligi, Ball, Testlar soni, Vaqt)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  infoTile(Icons.bar_chart, 'Quiz qiyinligi', 'O‘rtacha'),
                  const Divider(),
                  infoTile(Icons.emoji_events, 'Eng yuqori ball', '10 ball'),
                  const Divider(),
                  infoTile(Icons.list_alt, 'Testlar soni', '10 ta'),

                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget infoTile(IconData icon, String title, String value) {
      return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.orange.withOpacity(0.1),
          child: Icon(icon, color: Colors.orange),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(value),
      );
    }

  }

