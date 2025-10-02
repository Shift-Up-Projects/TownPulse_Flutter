import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:town_pulse2/core/router/app_router.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/core/utils/styles.dart';
import 'package:town_pulse2/features/auth/presentation/widgets/custom_button.dart';
import 'package:town_pulse2/features/auth/presentation/widgets/custom_text_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            maxRadius: 50,
            child: Icon(Icons.key_outlined, size: 50),
          ),
          SizedBox(height: 30),
          Text(
            'نسيت كلمة المرور ',
            style: Styles.textStyle30.copyWith(color: AppColors.primary),
          ),

          Text(
            'ادخل بريدك الالكتروني و سنرسل لك رابطاً \nلاعادة تعيين كلمة المرور  ',
            style: Styles.textStyle18,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),

          CustomTextField(
            text: 'البريد الالكتروني',
            iconButton: IconButton(
              onPressed: () {},
              icon: Icon(Icons.email_outlined),
            ),
          ),
          CustomButton(text: 'ارسال رابط الاعادة', onTap: () {}),
          TextButton(
            onPressed: () {
              context.go(AppRouter.signInScreen);
            },
            child: Text('العودة لتسجيل الدخول'),
          ),
        ],
      ),
    );
  }
}
