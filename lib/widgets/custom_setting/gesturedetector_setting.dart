import 'package:flutter/material.dart';

class SettingOption extends StatelessWidget {
  const SettingOption(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTaped});
  final String title;
  final IconData icon;
  final VoidCallback onTaped;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTaped,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
