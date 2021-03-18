import 'package:flutter/material.dart';

class HitMeButton extends StatelessWidget {
  HitMeButton({@required this.text, @required this.onPressed});
  final String text;
  final GestureTapCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      fillColor: Colors.red[700],
      splashColor: Colors.redAccent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          this.text,
          maxLines: 1,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            letterSpacing: 2.0  
          )
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: Colors.white)
      ),
    );
  }
}