import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class Balloon {
  Balloon({
    required this.id,
    required this.x,
    required this.y,
    required this.size,
    required this.color,
    required this.speed,
  });
  final String id;
  double x;
  double y;
  final double size;
  final Color color;
  final double speed;
}

class BalloonGameProvider extends ChangeNotifier {
  BalloonGameProvider();

  int score = 0;
  bool isGameStarted = false;
  bool isGamePaused = false;
  int timeLeft = 30; // 30 seconds
  int currentLevel = 1;
  int poppedBalloons = 0;
  int missedBalloons = 0;
  int totalBalloons = 0;
  int remainingBalloons = 0;

  final List<Balloon> balloons = [];

  Timer? _gameTimer;
  final List<Timer> _balloonTimers = [];
  final Random _random = Random();

  double _gameWidth = 100;
  double _gameHeight = 100;

  void updateGameAreaSize(double width, double height) {
    if (_gameWidth == width && _gameHeight == height) return;
    _gameWidth = width;
    _gameHeight = height;
    // Removed notifyListeners from here to prevent build loops.
  }

  void startGame(int number) {
    final balloonCount = number.clamp(1, 20);

    isGameStarted = true;
    isGamePaused = false;
    score = 0;
    timeLeft = 30;
    poppedBalloons = 0;
    missedBalloons = 0;
    currentLevel = 1;
    totalBalloons = balloonCount;
    remainingBalloons = balloonCount;
    balloons.clear();

    _cleanupTimers();

    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        timeLeft--;
        if (poppedBalloons >= currentLevel * 3) {
          currentLevel++;
        }
        if (balloons.length < 5 &&
            poppedBalloons + missedBalloons + balloons.length < totalBalloons) {
          _createBalloon();
        }
        notifyListeners();
      } else {
        stopGame();
      }
    });

    final initialBalloons = min(5, balloonCount);
    for (var i = 0; i < initialBalloons; i++) {
      _createBalloon();
    }
    notifyListeners();
  }

  void pauseGame() {
    isGamePaused = !isGamePaused;

    if (isGamePaused) {
      _gameTimer?.cancel();
    } else {
      _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (timeLeft > 0) {
          timeLeft--;
          if (balloons.length < 5 &&
              poppedBalloons + missedBalloons + balloons.length < totalBalloons) {
            _createBalloon();
          }
          notifyListeners();
        } else {
          stopGame();
        }
      });
      for (var balloon in balloons) {
        _startBalloonTimer(balloon);
      }
    }
    notifyListeners();
  }

  void stopGame() {
    _cleanupTimers();
    isGameStarted = false;
    isGamePaused = false;
    balloons.clear();
    notifyListeners();
  }

  void _createBalloon() {
    if (poppedBalloons + missedBalloons + balloons.length >= totalBalloons) {
      return;
    }

    final minSize = _gameWidth * 0.08;
    final maxSize = _gameWidth * 0.16;
    final size = _random.nextDouble() * (maxSize - minSize) + minSize;

    final baseSpeed = _gameHeight * 0.001;
    final speedFactor = _random.nextDouble() * 1.2 + 0.6;
    final speed = baseSpeed * speedFactor + (currentLevel * baseSpeed * 0.2);

    final horizontalPadding = size * 0.1;
    final maxX = _gameWidth - size - horizontalPadding;
    final minX = horizontalPadding;
    final x = maxX > minX ? _random.nextDouble() * (maxX - minX) + minX : minX;

    final balloon = Balloon(
      id: DateTime.now().millisecondsSinceEpoch.toString() + _random.nextInt(1000).toString(),
      x: x,
      y: _gameHeight + size,
      size: size,
      color: Color.fromARGB(
        255,
        _random.nextInt(200) + 55,
        _random.nextInt(200) + 55,
        _random.nextInt(200) + 55,
      ),
      speed: speed,
    );

    balloons.add(balloon);
    remainingBalloons = totalBalloons - (poppedBalloons + missedBalloons);

    _startBalloonTimer(balloon);
    notifyListeners();
  }

  void _startBalloonTimer(Balloon balloon) {
    final timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (!isGameStarted || isGamePaused) {
        timer.cancel();
        _balloonTimers.remove(timer);
        return;
      }

      final index = balloons.indexWhere((b) => b.id == balloon.id);
      if (index != -1) {
        balloons[index].y -= balloons[index].speed;

        if (balloons[index].x < 0) {
          balloons[index].x = 0;
        } else if (balloons[index].x > _gameWidth - balloons[index].size) {
          balloons[index].x = _gameWidth - balloons[index].size;
        }

        if (balloons[index].y < -balloons[index].size) {
          balloons.removeAt(index);
          missedBalloons++;
          remainingBalloons = totalBalloons - (poppedBalloons + missedBalloons);
          timer.cancel();
          _balloonTimers.remove(timer);

          if (poppedBalloons + missedBalloons >= totalBalloons) {
            _checkGameEnd();
          } else if (balloons.length < 5) {
            _createBalloon();
          }
        }
        notifyListeners();
      } else {
        timer.cancel();
        _balloonTimers.remove(timer);
      }
    });

    _balloonTimers.add(timer);
  }

  void popBalloon(int index) {
    if (index >= 0 && index < balloons.length) {
      final points = (100 / balloons[index].size * _gameWidth * 0.1).round();
      score += points;
      poppedBalloons++;
      balloons.removeAt(index);
      remainingBalloons = totalBalloons - (poppedBalloons + missedBalloons);

      if (poppedBalloons + missedBalloons >= totalBalloons) {
        _checkGameEnd();
      } else if (balloons.length < 5) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (isGameStarted && !isGamePaused) {
            _createBalloon();
          }
        });
      }
      notifyListeners();
    }
  }

  void _checkGameEnd() {
    if (poppedBalloons + missedBalloons >= totalBalloons) {
      Future.delayed(const Duration(seconds: 2), () {
        stopGame();
      });
    }
  }

  void _cleanupTimers() {
    _gameTimer?.cancel();
    _gameTimer = null;
    for (final timer in List<Timer>.from(_balloonTimers)) {
      timer.cancel();
    }
    _balloonTimers.clear();
  }

  @override
  void dispose() {
    _cleanupTimers();
    super.dispose();
  }
}
