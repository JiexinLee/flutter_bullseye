import 'package:flutter/material.dart';
import 'package:my_bullseye/textstyle.dart';
import 'styledbutton.dart';
import 'package:my_bullseye/about.dart';

class Info extends StatelessWidget {
  const Info({Key key, 
    @required this.totalScore,
    @required this.round,
    @required this.startOver
  }) : super(key: key);

  final int totalScore;
  final int round;
  final VoidCallback startOver;
  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StyledButton(
              onPressed: (){
                  startOver();
                },
              icon: Icons.refresh,
             ),
            Padding(
              padding: const EdgeInsets.only(left: 32.0, right: 32.0),
              child: Column(
                children: [
                  Text(
                    'Score: ',
                    style: LabelTextStyle.bodyText1(context),
                    ),
                  Text(
                    '$totalScore',
                    style: ScoreNumberTextStyle.headLine4(context),
                    ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          child: Column(
            children: [
              Text(
                'Round: ',
                style: LabelTextStyle.bodyText1(context)
              ),
              Text(
                '$round',
                style: ScoreNumberTextStyle.headLine4(context),
              ),
            ],
          ),
        ),
        StyledButton(onPressed: (){
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => AboutPage()),
          );
        }, icon: Icons.info,)
      ],
    );
  }
}