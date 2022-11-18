import 'package:flutter/material.dart';

class ScreenCell extends StatelessWidget {
  final bool isSnake;

  const ScreenCell({Key? key, required this.isSnake}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isSnake ? Colors.black : Colors.white,
    );
  }
}
