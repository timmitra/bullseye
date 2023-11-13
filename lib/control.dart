import 'package:flutter/material.dart';
import 'game_model.dart';

class Control extends StatefulWidget {
  const Control({required this.model, super.key});

  final GameModel model;

  @override
  State<Control> createState() => _ControlState();
}

class _ControlState extends State<Control> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 90.0),
          child: Text('1', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Slider(
            value: widget.model.current.toDouble(),
            onChanged: (newValue) {
              setState(() {
                widget.model.current = newValue.toInt();
              });
            },
            min: 1.0,
            max: 100.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 90.0),
          child:
              const Text('100', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
