import 'dart:math';

enum Result {
  tooHigh,
  tooLow,
  correct
}

class Game {
  int? _answer;
  int _guessCount = 0;

  Game() {
    var r = Random();
    _answer = r.nextInt(100) + 1;
  }

  int get guessCount {
    return _guessCount;
  }

  Result doGuess(int num) {
    _guessCount++;
    if (num > _answer!) {
      return Result.tooHigh;
    } else if (num < _answer!) {
      return Result.tooLow;
    } else {
      return Result.correct;
    }
  }
}