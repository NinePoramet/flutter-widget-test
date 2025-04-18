import 'package:flutter/material.dart';

class Finonaccis {
  List<FinonacciNumber> fiboNumbers = [];

  // constructor
  Finonaccis() {
    generateFibonacci(41);
  }

  //gen fibonacci numbers
  void generateFibonacci(int n) {
    fiboNumbers = [FinonacciNumber(0, 0), FinonacciNumber(1, 1)];
    for (int i = 2; i < n; i++) {
      fiboNumbers.add(FinonacciNumber(
          i, fiboNumbers[i - 1].number + fiboNumbers[i - 2].number));
    }
  }
}

class FinonacciNumber {
  int index;
  int number;
  late int type;

  FinonacciNumber(this.index, this.number) {
    type = calculateType();
  }

  //calculate type by number%3
  int calculateType() {
    if (number % 3 == 0) {
      type = 0;
    } else if (number % 3 == 1) {
      type = 1;
    } else {
      type = 2;
    }
    return type;
  }

  //getter type icon
  IconData getTypeIcon() {
    if (type == 0) {
      return Icons.circle;
    } else if (type == 1) {
      return Icons.crop_square_sharp;
    } else {
      return Icons.close;
    }
  }
}
