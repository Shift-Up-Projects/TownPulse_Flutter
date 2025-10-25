// lib/features/activity/presentation/views/search_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/core/utils/styles.dart';
import 'package:town_pulse2/core/widgets/shimmer_loading.dart';
import 'package:town_pulse2/features/activity/presentation/cubit/activity_cubit.dart';
import 'package:town_pulse2/features/activity/presentation/cubit/activity_state.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/card_of_activities.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    context.read<ActivityCubit>().getAllActivity();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'ابحث عن نشاط...',
            hintStyle: Styles.textStyle16.copyWith(color: Colors.grey),
            border: InputBorder.none,
          ),
          style: Styles.textStyle16,
          onChanged: (query) {
            context.read<ActivityCubit>().searchActivities(query);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              context.read<ActivityCubit>().getAllActivity();
            },
          ),
        ],
      ),
      body: BlocBuilder<ActivityCubit, ActivityState>(
        builder: (context, state) {
          if (state is ActivityLoading) {
            return const Center(child: ShimmerLoading());
          } else if (state is ActivityError) {
            return Center(child: Text('خطأ في البحث: ${state.message}'));
          } else if (state is ActivityLoaded) {
            final activities = state.activities;
            if (activities.isEmpty && _searchController.text.isNotEmpty) {
              return Center(
                child: Text('لا توجد نتائج للبحث "${_searchController.text}"'),
              );
            }
            if (activities.isEmpty && _searchController.text.isEmpty) {
              return Center(child: Text('ابدأ البحث عن أنشطة المدينة'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: CardOfActivity(activity: activity),
                );
              },
            );
          }
          return Center(child: Text('ابدأ البحث عن أنشطة المدينة'));
        },
      ),
    );
  }
}
