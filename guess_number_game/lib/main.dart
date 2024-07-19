import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess the Number Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guess the Number Game'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Start Game'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GameScreen()),
            );
          },
        ),
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final _randomNumber = Random().nextInt(50) + 1;
  final _controller = TextEditingController();
  int _attempts = 0;
  int _score = 0;
  String _feedback = '';

  void _checkGuess() {
    final guess = int.tryParse(_controller.text);
    if (guess == null || guess < 1 || guess > 50) {
      setState(() {
        _feedback = 'Please enter a valid number between 1 and 50.';
      });
      return;
    }

    _attempts++;
    int points = 20;
    if (guess == _randomNumber) {
      points = 100;
      _feedback = 'Perfect guess! The number was $_randomNumber.';
    } else if ((guess - _randomNumber).abs() <= 5) {
      points = 80;
      _feedback = guess > _randomNumber
          ? 'Very close, but too high.'
          : 'Very close, but too low.';
    } else if ((guess - _randomNumber).abs() <= 10) {
      points = 50;
      _feedback = guess > _randomNumber
          ? 'Close, but too high.'
          : 'Close, but too low.';
    } else {
      _feedback = guess > _randomNumber ? 'Too high.' : 'Too low.';
    }

    _score += points;

    if (_attempts >= 5 || guess == _randomNumber) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: _score,
            randomNumber: _randomNumber,
          ),
        ),
      );
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guess the Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter your guess (1-50)',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('Submit Guess'),
              onPressed: _checkGuess,
            ),
            SizedBox(height: 20),
            Text(
              _feedback,
              style: TextStyle(
                fontSize: 18,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Attempts: $_attempts/5',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              'Score: $_score',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final int score;
  final int randomNumber;

  ResultScreen({required this.score, required this.randomNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Over'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Game Over!',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'The number was $randomNumber',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Your Score: $score',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Play Again'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
