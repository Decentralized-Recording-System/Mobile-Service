import 'package:flutter/material.dart';

class HeadTitle extends StatelessWidget {
  const HeadTitle({super.key, required this.name, required this.color});
  final String name;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
            )),
        Expanded(
            flex: 2,
            child: Container(
              color: Colors.amberAccent,
              child: Center(child: Text(name)),
            )),
      ],
    );
  }
}
