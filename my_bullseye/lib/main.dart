import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_bullseye/control.dart';
import 'package:my_bullseye/info.dart';
import 'package:my_bullseye/prompt.dart';
import 'gamemodel.dart';
import 'package:my_bullseye/hitmebutton.dart';
import 'package:my_bullseye/textstyle.dart';
import 'package:my_bullseye/styledbutton.dart';

void main() => runApp(BullsEyeGame());

class BullsEyeGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    // For Android device: put the status menu behind the game
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'BullsEye',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: GamePage(title: 'BullsEye'),
    );
  }
}

class GamePage extends StatefulWidget {
  GamePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool _alertIsVisible = false;
  GameModel _model;

  @override
  void initState() {
    super.initState();
    _model = GameModel(_getNewTarget());
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(image: AssetImage('images/background.png'),
        fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 38.0, bottom: 38.0),
            child: Prompt(targetValue: _model.target),
          ),
          Control(model: _model),
          Padding(
            padding: const EdgeInsets.only(top: 28.0, bottom: 20.0),
            child: HitMeButton(
                onPressed: () {
                  this._alertIsVisible = true;
                  _showPopup(context);
                  },
                text: 'HIT ME!', 
              ),
          ),
          Info(
            round: _model.round,
            totalScore: _model.totalScore,
            startOver: _startNewGame,
          )
        ],
      ))),
    );
  }

  int _sliderValue() => _model.currentValue;
  int _getNewTarget() => Random().nextInt(100) + 1;
  void _startNewGame() {
    setState(() {
      _model.target = _getNewTarget();
      _model.totalScore = GameModel.START_SCORE;
      _model.round = GameModel.START_ROUND;
      _model.currentValue = GameModel.START_VALUE;
    });
  }

  String _getAlertTitle() {
    int currentTarget = _model.target;
    int difference = (currentTarget - _sliderValue()).abs();
    if (difference == 0) {
      return "Perfect!";
    } else if (difference == 1) {
      return "You almost there!";
    } else if (1 < difference && difference <= 5) {
      return "Not Bad!";
    }
    return "Did you even try?";
  }

  int _pointsForScore() {
    int currentTarget = _model.target;
    int difference = (currentTarget - _sliderValue()).abs();
    int bonus = 0;
    if (difference == 0) {
      bonus = 100;
    } else if (difference <= 5 && difference > 0) {
      bonus = 50;
    }
    return 100 - difference + bonus;
  }

  void _showPopup(BuildContext context) {
    Widget okButton = StyledButton(
        onPressed: () {
          Navigator.of(context).pop();
          this._alertIsVisible = false;
          setState(() {
            _model.totalScore += _pointsForScore();
            _model.target = _getNewTarget();
            _model.round += 1;
          });
        },
        icon: Icons.close_rounded
        );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '${_getAlertTitle()}',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "The Slider's value is",
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${_sliderValue()}',
                  style: TargetTextStyle.bodyText1(context),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "\nYour score is ${_pointsForScore()} points for this round. ",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: <Widget>[
              okButton,
            ],
            elevation: 5,
          );
        });
  }
}
