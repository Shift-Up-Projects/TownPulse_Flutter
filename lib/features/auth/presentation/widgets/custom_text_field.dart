import 'package:flutter/material.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/core/utils/styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.text,

    required this.iconButton,
    this.obscureText = false,
    this.color = AppColors.textPrimary,
  });
  final String text;

  final IconButton iconButton;
  final Color color;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: Styles.textStyle14.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          TextFormField(
            obscureText: obscureText,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            validator: (value) {
              if (value!.isEmpty) {
                return 'هذا الحقل مطلوب';
              }
              return null;
            },
            decoration: InputDecoration(
              suffixIcon: iconButton,
              // labelText: text,
              floatingLabelStyle: TextStyle(color: color),
              labelStyle: TextStyle(color: color),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: color),
                borderRadius: BorderRadius.circular(12),
                gapPadding: 12,
              ),
              hintText: text,
              hintStyle: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
