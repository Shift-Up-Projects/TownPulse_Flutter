import 'package:flutter/material.dart';
import 'package:town_pulse2/core/utils/styles.dart';

class CardHorizontalListOfMainScreen extends StatelessWidget {
  const CardHorizontalListOfMainScreen({
    super.key,
    required this.text,
    required this.icon,
    this.isSelected = true,
  });
  final String text;
  final IconData icon;
  final isSelected;
  @override
  Widget build(BuildContext context) {
    // final bg = isSelected ? Theme.of(context).primaryColor : Colors.white;
    // final txtColor = isSelected ? Colors.white : Colors.black87;
    final iconColor = isSelected ? Colors.white : Colors.black54;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),

      // padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
      child: Card(
        shape: ShapeBorder.lerp(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected ? Theme.of(context).primaryColor : Colors.black,
              width: 1.5,
            ),
          ),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          1,
        ),
        // color: iconColor,
        elevation: 2,
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 30, color: iconColor),
              const SizedBox(height: 10),
              Text(text, style: Styles.textStyle18),
            ],
          ),
        ),
      ),
    );
  }
}
