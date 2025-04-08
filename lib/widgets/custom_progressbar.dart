import 'package:flutter/material.dart';

class CustomProgressbar extends StatefulWidget {
  final double progress;
  const CustomProgressbar({super.key, required this.progress});

  @override
  State<CustomProgressbar> createState() => _CustomProgressbarState();
}

class _CustomProgressbarState extends State<CustomProgressbar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton( onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.close, size: 20, color: Colors.black)), // X ikonkasi

        Stack(
          children: [
            Container(
              width: 240,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 250 * widget.progress,
              height: 20,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),

        IconButton(
          onPressed: () {},
          icon: Icon(Icons.access_time, color: Color(0xFFFFA726), size: 25),
        ),

        Icon(
          Icons.all_inclusive,
          size: 25,
          color: Colors.black,
        ), // Infinity icon
      ],
    );
  }
}
