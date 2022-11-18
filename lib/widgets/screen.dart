import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screen_cell.dart';
import '../providers/snake.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    final snakeData = Provider.of<Snake>(context);
    int cellInRow = snakeData.cellInRow;
    final food = snakeData.curFood;
    List<CellSnake> snake = snakeData.snake;
    int cellTotal = cellInRow * cellInRow;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cellInRow,
      ),
      itemBuilder: (BuildContext ctx, int ind) {
        var col = ind % cellInRow;
        var row = ind ~/ cellInRow;
        var isCellSnake = snake.any((cell) =>
            (cell.col == col && cell.row == row ||
                food.col == col && food.row == row));
        return ScreenCell(isSnake: isCellSnake);
      },
      itemCount: cellTotal,
    );
  }
}
