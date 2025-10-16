import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/features/activity/data/category_consts.dart';
import 'package:town_pulse2/features/activity/presentation/cubit/activity_cubit.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/card_horizontal_list_of_main_screen.dart';

class HorizontalListOfMainScreen extends StatefulWidget {
  HorizontalListOfMainScreen({super.key});

  @override
  State<HorizontalListOfMainScreen> createState() =>
      _HorizontalListOfMainScreenState();
}

class _HorizontalListOfMainScreenState
    extends State<HorizontalListOfMainScreen> {
  String selectedCategory = 'ALL';
  @override
  Widget build(BuildContext context) {
    final activiyCubit = context.read<ActivityCubit>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 1 / 4.5,
        child: Scrollbar(
          thickness: 3,
          // thumbVisibility: true,
          trackVisibility: true,
          radius: Radius.circular(8),

          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 10),
            scrollDirection: Axis.horizontal,
            itemCount: categoriesList.length,
            itemBuilder: (context, index) {
              final category = categoriesList[index];
              final isSelected = category.key == selectedCategory;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = category.key;
                    activiyCubit.fetchAllActivity(
                      category: selectedCategory == 'ALL'
                          ? null
                          : selectedCategory,
                    );
                  });
                },
                child: CardHorizontalListOfMainScreen(
                  icon: category.icon,
                  text: category.label,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
