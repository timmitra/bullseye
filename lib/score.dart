import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  const Score({required this.totalScore, required this.round, super.key});

  final int totalScore;
  final int round;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(child: const Text('Start Over'), onPressed: () {}),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text('Score: '),
              Text('99999'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text('Round: '),
              Text('999'),
            ],
          ),
        ),
        TextButton(child: const Text('Info'), onPressed: () {}),
      ],
    );
  }
}
