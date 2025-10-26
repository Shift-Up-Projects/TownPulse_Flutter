import 'package:flutter/material.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';

class CreateButton extends StatelessWidget {
  final bool loading;
  final VoidCallback onPressed;
  final String text;

  const CreateButton({
    super.key,
    required this.loading,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: loading ? null : onPressed,
        icon: loading ? const SizedBox.shrink() : const Icon(Icons.add),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: loading
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
