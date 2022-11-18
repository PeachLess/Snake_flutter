import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/snake.dart';

class Buttons extends StatelessWidget {
  const Buttons({Key? key}) : super(key: key);

  Widget buildButoon(Direction direction, String title, Snake data) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ElevatedButton(
            onPressed: () {
              data.runSnake(direction);
            },
            child: Text(title)));
  }

  @override
  Widget build(BuildContext context) {
    final snakeData = Provider.of<Snake>(context);
    return Center(
      child: snakeData.isPlay
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButoon(Direction.up, 'Up', snakeData),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildButoon(Direction.left, 'Left', snakeData),
                    buildButoon(Direction.right, 'Right', snakeData)
                  ],
                ),
                buildButoon(Direction.down, 'Down', snakeData)
              ],
            )
          : (ElevatedButton(
              child: const Text('Start'),
              onPressed: () {
                snakeData.start();
              },
            )),
    );
  }
}
