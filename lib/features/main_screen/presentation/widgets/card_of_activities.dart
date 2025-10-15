import 'package:flutter/material.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/core/utils/styles.dart';

class CardOfActivity extends StatelessWidget {
  const CardOfActivity({
    super.key,
    required this.image,
    required this.title,
    required this.category,
    required this.date,
    required this.dateTime,
    required this.location,
  });
  final String image;
  final String title;
  final String category;
  final String date;
  final String dateTime;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // Image.asset(
          //   image,
          //   height: 200,
          //   fit: BoxFit.cover,
          //   width: double.infinity,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Styles.textStyle20.copyWith(fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(category, style: Styles.textStyle16.copyWith()),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.date_range, color: Colors.grey),
              SizedBox(width: 5),
              Text(
                date,
                style: Styles.textStyle16.copyWith(color: Colors.grey),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.timer_outlined, color: Colors.grey),
              SizedBox(width: 5),
              Text(
                dateTime,
                style: Styles.textStyle16.copyWith(color: Colors.grey),
              ),
            ],
          ),

          Row(
            children: [
              Icon(Icons.location_on, color: Colors.grey),
              SizedBox(width: 5),
              Text(
                location,
                style: Styles.textStyle16.copyWith(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
