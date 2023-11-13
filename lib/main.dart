import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'prompt.dart';
import 'control.dart';
import 'score.dart';
import 'game_model.dart';
import 'dart:math';
import 'hit_me_button.dart';
import 'styled_button.dart';

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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
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
    _model = GameModel(_newTargetValue());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 48.0, bottom: 32.0),
                child: Prompt(targetValue: _model.target),
              ),
              Control(model: _model),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: HitMeButton(
                    text: 'HIT ME',
                    onPressed: () {
                      _showAlert(context);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Score(
                  totalScore: _model.totalScore,
                  round: _model.round,
                  onStartOver: _startNewGame,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  int _pointForCurrentRound() {
    var bonus = 0;
    const maximumScore = 100;
    var difference = _differenceAmount();
    if (difference == 0) {
      bonus = 100;
    } else if (difference <= 5) {
      bonus = 50;
    }
    return maximumScore - difference + bonus;
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

  int _newTargetValue() => Random().nextInt(100) + 1;

  void _startNewGame() {
    setState(() {
      _model.totalScore = GameModel.scoreStart;
      _model.round = GameModel.roundStart;
      _model.current = GameModel.sliderStart;
      _model.target = _newTargetValue();
    });
  }

  void _showAlert(BuildContext context) {
    var okButton = StyledButton(
      icon: Icons.close,
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          _model.totalScore += _pointForCurrentRound();
          _model.target = _newTargetValue();
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
