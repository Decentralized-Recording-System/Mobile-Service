import 'package:flutter/material.dart';

class LisTileSetting extends StatelessWidget {
  const LisTileSetting({
    super.key,
    required this.icon,
    required this.title,
  });
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(leading: Icon(icon), title: Text(title));
    ;
  }
}
