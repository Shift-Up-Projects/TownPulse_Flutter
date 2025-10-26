import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:town_pulse2/features/activity/presentation/cubit/activity_cubit.dart';
import 'package:town_pulse2/core/widgets/showToast.dart';

Future<void> getNearby(BuildContext context, int maxDistance) async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ShowToast(message: 'خدمة الموقع غير مفعلة.', state: toastState.warning);
    return;
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ShowToast(message: 'تم رفض إذن الموقع.', state: toastState.error);
      return;
    }
  }

  try {
    final pos = await determinePosition();
    if (pos != null) {
      context.read<ActivityCubit>().fetchNearbyActivities(
        pos.latitude,
        pos.longitude,
        maxDistance,
      );
    }
  } catch (e) {
    ShowToast(message: e.toString(), state: toastState.error);
  }
}

Future<Position?> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('الرجاء تفعيل خدمة الموقع');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('تم رفض إذن الموقع');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('تم رفض إذن الموقع بشكل دائم');
  }

  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}
