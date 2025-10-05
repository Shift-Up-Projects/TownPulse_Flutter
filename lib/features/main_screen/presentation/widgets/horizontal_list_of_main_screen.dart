import 'package:flutter/material.dart';
import 'package:town_pulse2/features/main_screen/presentation/widgets/card_horizontal_list_of_main_screen.dart';

class HorizontalListOfMainScreen extends StatelessWidget {
  HorizontalListOfMainScreen({super.key});
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 1 / 5,
        child: Scrollbar(
          thickness: 3,
          thumbVisibility: true,
          trackVisibility: true,
          radius: Radius.circular(8),
          controller: _scrollController,
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 10),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) =>
                const CardHorizontalListOfMainScreen(
                  icon: Icons.border_all_rounded,
                  text: 'الكل',
                ),
          ),
        ),
      ),
    );
  }
}
