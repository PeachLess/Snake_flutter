import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

enum Direction { up, right, down, left }

class CellSnake {
  final int row;
  final int col;

  CellSnake({required this.row, required this.col});
}

class Snake with ChangeNotifier {
  var isPlay = false;
  var cellInRow = 20;
  var curTimer;
  var curDir = Direction.right;

  final duration = const Duration(milliseconds: 500);

  var curFood = CellSnake(col: -1, row: -1);

  late List<CellSnake> _snake = [];

  late List<CellSnake> newSnake = [
    CellSnake(row: cellInRow ~/ 2, col: cellInRow ~/ 2 + 1),
    CellSnake(row: cellInRow ~/ 2, col: cellInRow ~/ 2),
    CellSnake(row: cellInRow ~/ 2, col: cellInRow ~/ 2 - 1),
    CellSnake(row: cellInRow ~/ 2, col: cellInRow ~/ 2 - 2),
    CellSnake(row: cellInRow ~/ 2, col: cellInRow ~/ 2 - 3)
  ];

  List<CellSnake> get snake {
    if (_snake.isEmpty) {
      _snake = [...newSnake];
    }
    return [..._snake];
  }

  void refreshFood() {
    curFood = CellSnake(
        row: Random().nextInt(cellInRow), col: Random().nextInt(cellInRow));
    if (snake
        .any((cell) => (cell.row == curFood.row && cell.col == curFood.col))) {
      refreshFood();
    }
  }

  void removeFood() {
    curFood = CellSnake(col: -1, row: -1);
  }

  void start() {
    refreshFood();
    isPlay = true;
    runSnake(Direction.right);
  }

  void end() {
    removeFood();
    isPlay = false;
    _snake = [...newSnake];
  }

  void runSnake(Direction direction) {
    switch (direction) {
      case Direction.up:
        if (curDir == Direction.down) {
          break;
        }
        if (curTimer != null) curTimer.cancel();
        curDir = Direction.up;
        Timer.periodic(duration, (timer) => snakeUp(timer));
        break;
      case Direction.right:
        if (curDir == Direction.left) {
          break;
        }
        if (curTimer != null) curTimer.cancel();
        curDir = Direction.right;
        Timer.periodic(duration, (timer) => snakeRight(timer));
        break;
      case Direction.down:
        if (curDir == Direction.up) {
          break;
        }
        if (curTimer != null) curTimer.cancel();
        curDir = Direction.down;
        Timer.periodic(duration, (timer) => snakeDown(timer));
        break;
      case Direction.left:
        if (curDir == Direction.right) {
          break;
        }
        if (curTimer != null) curTimer.cancel();
        curDir = Direction.left;
        Timer.periodic(duration, (timer) => snakeLeft(timer));
        break;
      default:
        break;
    }
  }

  void snakeUp(Timer timer) {
    curTimer = timer;
    var curRow = _snake[0].row;
    var curCol = _snake[0].col;
    if (snake.any((cell) => (cell.row == curRow - 1 && cell.col == curCol)) ||
        curRow == 0) {
      timer.cancel();
      end();
    } else {
      _snake.insert(0, CellSnake(row: curRow - 1, col: curCol));
      _snake.removeLast();
      if (curFood.row == curRow - 2 && curFood.col == curCol) {
        _snake.insert(0, curFood);
        refreshFood();
      }
    }
    notifyListeners();
  }

  void snakeRight(Timer timer) {
    curTimer = timer;
    var curRow = _snake[0].row;
    var curCol = _snake[0].col;
    if (snake.any((cell) => (cell.row == curRow && cell.col == curCol + 1)) ||
        curCol == cellInRow - 1) {
      timer.cancel();
      end();
    } else {
      _snake.insert(0, CellSnake(row: curRow, col: curCol + 1));
      _snake.removeLast();
      if (curFood.row == curRow && curFood.col == curCol + 2) {
        _snake.insert(0, curFood);
        refreshFood();
      }
    }
    notifyListeners();
  }

  void snakeDown(Timer timer) {
    curTimer = timer;
    var curRow = _snake[0].row;
    var curCol = _snake[0].col;
    if (snake.any((cell) => (cell.row == curRow + 1 && cell.col == curCol)) ||
        curRow == cellInRow - 1) {
      timer.cancel();
      end();
    } else {
      _snake.insert(0, CellSnake(row: curRow + 1, col: curCol));
      _snake.removeLast();
      if (curFood.row == curRow + 2 && curFood.col == curCol) {
        _snake.insert(0, curFood);
        refreshFood();
      }
    }
    notifyListeners();
  }

  void snakeLeft(Timer timer) {
    curTimer = timer;
    var curRow = _snake[0].row;
    var curCol = _snake[0].col;
    if (snake.any((cell) => (cell.row == curRow && cell.col == curCol - 1)) ||
        curCol == 0) {
      timer.cancel();
      end();
    } else {
      _snake.insert(0, CellSnake(row: curRow, col: curCol - 1));
      _snake.removeLast();
      if (curFood.row == curRow && curFood.col == curCol - 2) {
        _snake.insert(0, curFood);
        refreshFood();
      }
    }
    notifyListeners();
  }
}
