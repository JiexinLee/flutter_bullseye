import 'package:flutter/material.dart';
import 'package:my_bullseye/textstyle.dart';

class Prompt extends StatelessWidget {
  Prompt({@required this.targetValue});
  final int targetValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "PULL THE BULL'S EYE AS CLOSE AS YOU CAN TO",
          style: LabelTextStyle.bodyText1(context),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$targetValue',
            style: TargetTextStyle.bodyText1(context),
            ),
        )
      ],
    );
  }
}