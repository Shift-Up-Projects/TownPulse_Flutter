import 'package:flutter/material.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/core/utils/styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.text,
    this.textInputType,
    this.suffixIconButton,

    this.obscureText = false,
    this.color = AppColors.textPrimary,
    required this.prefixIcon,
    required this.controller,
  });
  final String text;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final IconButton? suffixIconButton;
  final IconData prefixIcon;
  final Color color;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: Styles.textStyle14.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        TextFormField(
          controller: controller,
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
            prefixIcon: Icon(prefixIcon),
            suffixIcon: suffixIconButton,
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
    );
  }
}
