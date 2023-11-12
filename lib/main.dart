import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'prompt.dart';
import 'control.dart';
import 'score.dart';
import 'game_model.dart';
import 'dart:math';

void main() {
  runApp(const BullseyeApp());
}

class BullseyeApp extends StatelessWidget {
  const BullseyeApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return const MaterialApp(
      title: 'Bullseye',
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GameModel _model;

  @override
  void initState() {
    super.initState();
    _model = GameModel(Random().nextInt(100) + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Prompt(targetValue: _model.target),
            Control(model: _model),
            TextButton(
              child:
                  const Text("Hit Me!", style: TextStyle(color: Colors.blue)),
              onPressed: () {
                _showAlert(context);
              },
            ),
            Score(totalScore: _model.totalScore, round: _model.round)
          ],
        ),
      ),
    );
  }

  int _pointForCurrentRound() {
    const maximumScore = 100;
    var difference = _differenceAmount();
    return maximumScore - difference;
  }

  String _alertTitle() {
    var difference = _differenceAmount();
    String title;
    if (difference == 0) {
      title = "Perfect!";
    } else if (difference < 5) {
      title = "Almost had it!";
    } else if (difference <= 10) {
      title = "Not bad.";
    } else {
      title = "Not even close!";
    }
    return title;
  }

  int _differenceAmount() => (_model.target - _model.current).abs();

  void _showAlert(BuildContext context) {
    var okButton = TextButton(
      child: const Text('Awesome!'),
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          _model.totalScore += _pointForCurrentRound();
          _model.target = Random().nextInt(100) + 1;
          _model.round = _model.round += 1;
        });
      },
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_alertTitle()),
          content: Text('the slider\'s value is a ${_model.current}.\n'
              'You scored ${_pointForCurrentRound()} points this round'),
          actions: [
            okButton,
          ],
          elevation: 5,
        );
      },
    );
  }
}
