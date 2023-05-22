import 'package:flutter/material.dart';

class TelemeticsButton extends StatelessWidget {
  const TelemeticsButton(
      {super.key, required this.onPressed, required this.text});
  final void Function() onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).textTheme.bodyText2?.color,
        padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
