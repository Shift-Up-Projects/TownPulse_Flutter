// lib/core/widget/shimmer_loading.dart

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';

// هذا هو الويدجت الرئيسي لتأثير Shimmer
class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.bgSecondary,
      highlightColor: AppColors.bgTertiary,
      child: ShimmerContainer(
        width: double.infinity,
        height: 100,
        borderRadius: 12,
        shapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class ShimmerContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final ShapeBorder shapeBorder;

  const ShimmerContainer({
    super.key,
    this.width,
    this.height,
    this.shapeBorder = const RoundedRectangleBorder(),
    int borderRadius = 24,
  });

  const ShimmerContainer.circular({super.key, required double size})
    : width = size,
      height = size,
      shapeBorder = const CircleBorder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(color: Colors.grey[300]!, shape: shapeBorder),
    );
  }
}
