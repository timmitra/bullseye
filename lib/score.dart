import 'package:flutter/cupertino.dart';

class Score extends StatelessWidget {
  const Score(
      {required this.totalScore,
      required this.round,
      required this.onStartOver,
      super.key});

  final int totalScore;
  final int round;
  final VoidCallback onStartOver;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CupertinoButton(
            child: const Text('Start Over'),
            onPressed: () {
              onStartOver();
            }),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              const Text('Score: '),
              Text('$totalScore'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              const Text('Round: '),
              Text('$round'),
            ],
          ),
        ),
        CupertinoButton(child: const Text('Info'), onPressed: () {}),
      ],
    );
  }
}
