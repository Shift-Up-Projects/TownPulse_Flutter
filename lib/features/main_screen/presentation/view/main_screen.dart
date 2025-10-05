import 'package:flutter/material.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/core/utils/styles.dart';
import 'package:town_pulse2/features/main_screen/presentation/widgets/card_horizontal_list_of_main_screen.dart';
import 'package:town_pulse2/features/main_screen/presentation/widgets/horizontal_list_of_main_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Text(
                'الفئات',
                style: Styles.textStyle20.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(onPressed: () {}, child: Text('عرض الكل')),
            ],
          ),
          HorizontalListOfMainScreen(),

          SizedBox(height: 16),
          Row(
            children: [
              Text(
                'الانشطة المتاحة',
                style: Styles.textStyle20.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(onPressed: () {}, child: Text('عرض الكل')),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => CardOfActivity(
                category: 'ثقافي',
                dateTime: DateTime.now().toString(),
                date: '8 : 00',
                image: 'assets/test.webp',
                location: 'الرياض',
                title: 'معرض الفن المعاصر',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
          Image.asset(
            image,
            height: 200,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Styles.textStyle20),
              Text(
                category,
                style: Styles.textStyle20.copyWith(
                  backgroundColor: AppColors.primaryDark,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.date_range),
              SizedBox(width: 5),
              Text(date, style: Styles.textStyle16),
            ],
          ),
          Row(
            children: [
              Icon(Icons.timer_outlined),
              SizedBox(width: 5),
              Text(dateTime, style: Styles.textStyle16),
            ],
          ),

          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.location_on),
              SizedBox(width: 5),
              Text(location, style: Styles.textStyle16),
            ],
          ),
        ],
      ),
    );
  }
}
