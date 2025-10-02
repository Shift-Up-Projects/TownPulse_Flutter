import 'package:flutter/material.dart';

class AppColors {
  // 🎨 الألوان الأساسية
  static const Color primary = Color(0xFF6366F1); // اللون الأساسي
  static const Color primaryDark = Color(0xFF4F46E5); // أساسي داكن
  static const Color primaryLight = Color(0xFF818CF8); // أساسي فاتح

  // 🌈 الألوان الثانوية والمميزة
  static const Color secondary = Color(0xFF10B981); // ثانوي – أخضر
  static const Color accent = Color(0xFFF59E0B); // لون مميز – برتقالي/ذهبي

  // ✅ حالات
  static const Color success = Color(0xFF10B981); // نجاح
  static const Color warning = Color(0xFFF59E0B); // تحذير
  static const Color error = Color(0xFFEF4444); // خطأ

  // 🖤 الخلفيات والنصوص
  static const Color bgPrimary = Color(0xFF0F172A); // خلفية أساسية داكنة
  static const Color bgSecondary = Color(0xFF1E293B);
  static const Color bgTertiary = Color(0xFF334155);

  static const Color textPrimary = Color(0xFFF8FAFC); // نص فاتح
  static const Color textSecondary = Color(0xFFCBD5E1); // نص رمادي فاتح
  static const Color textMuted = Color(0xFF64748B); // نص رمادي باهت
  static const Color textLightGray = Color(0xFF6B7280);

  // 🌟 أيقونات الفئات
  static const Color categoryCulturalBg = Color.fromRGBO(168, 85, 247, 0.2);
  static const Color categoryCulturalIcon = Color(0xFFA855F7);

  static const Color categorySportsBg = Color.fromRGBO(34, 197, 94, 0.2);
  static const Color categorySportsIcon = Color(0xFF22C55E);

  static const Color categoryFamilyBg = Color.fromRGBO(249, 115, 22, 0.2);
  static const Color categoryFamilyIcon = Color(0xFFF97316);

  static const Color categoryFoodBg = Color.fromRGBO(245, 158, 11, 0.2);
  static const Color categoryFoodIcon = Color(0xFFF59E0B);

  static const Color categoryEducationalBg = Color.fromRGBO(59, 130, 246, 0.2);
  static const Color categoryEducationalIcon = Color(0xFF3B82F6);

  // ⏳ حالة الأحداث
  static const Color statusPlannedBg = Color.fromRGBO(59, 130, 246, 0.2);
  static const Color statusPlanned = Color(0xFF3B82F6);

  static const Color statusOngoingBg = Color.fromRGBO(34, 197, 94, 0.2);
  static const Color statusOngoing = Color(0xFF22C55E);

  static const Color statusEndedBg = Color.fromRGBO(107, 114, 128, 0.2);
  static const Color statusEnded = Color(0xFF6B7280);

  static const Color statusCancelledBg = Color.fromRGBO(239, 68, 68, 0.2);
  static const Color statusCancelled = Color(0xFFEF4444);

  // 🕶️ الشفافية والظلال
  static const Color shadowSmall = Color.fromRGBO(0, 0, 0, 0.05);
  static const Color shadowMedium = Color.fromRGBO(0, 0, 0, 0.1);

  static const Color overlayDark95 = Color.fromRGBO(15, 23, 42, 0.95);
  static const Color overlayDark90 = Color.fromRGBO(15, 23, 42, 0.9);
  static const Color overlayDark80 = Color.fromRGBO(0, 0, 0, 0.8);

  static const Color overlayWhite10 = Color.fromRGBO(255, 255, 255, 0.1);
  static const Color overlayWhite20 = Color.fromRGBO(255, 255, 255, 0.2);
  static const Color overlayWhite30 = Color.fromRGBO(255, 255, 255, 0.3);
  static const Color overlayWhite40 = Color.fromRGBO(255, 255, 255, 0.4);
  static const Color overlayWhite90 = Color.fromRGBO(255, 255, 255, 0.9);
}
