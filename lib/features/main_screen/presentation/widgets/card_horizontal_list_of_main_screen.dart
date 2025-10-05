import 'package:flutter/material.dart';
import 'package:town_pulse2/core/utils/styles.dart';

class CardHorizontalListOfMainScreen extends StatelessWidget {
  const CardHorizontalListOfMainScreen({
    super.key,
    required this.text,
    required this.icon,
  });
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32),
            const SizedBox(height: 18),
            Text(text, style: Styles.textStyle18),
          ],
        ),
      ),
    );
  }
}
