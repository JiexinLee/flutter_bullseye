import 'package:flutter/material.dart';
import 'gamemodel.dart';

class Control extends StatefulWidget {
  Control({Key key, @required this.model}) : super(key: key);
  final GameModel model;

  @override
  _ControlState createState() => _ControlState();
}


class _ControlState extends State<Control>{
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 60.0),
          child: Text(
            '1',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Slider(
            value: widget.model.currentValue.toDouble(),
            onChanged: (newValue) {
              setState(() {
                widget.model.currentValue = newValue.toInt();
              });
            },
            min: 1.0,
            max: 100.0,
            inactiveColor: Colors.red[300],
            activeColor: Colors.red[700],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30.0),
          child: Text(
            '100',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
