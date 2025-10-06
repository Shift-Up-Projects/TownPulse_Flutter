import 'package:flutter/material.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/core/utils/styles.dart';
import 'package:town_pulse2/features/auth/presentation/widgets/custom_button.dart';
import 'package:town_pulse2/features/auth/presentation/widgets/custom_text_field.dart'
    show CustomTextField;

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
      child: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),

          CircleAvatar(
            maxRadius: 50,
            child: Icon(Icons.home_work_outlined, size: 50),
          ),
          Text(
            'TownPulse',
            textAlign: TextAlign.center,
            style: Styles.textStyle30.copyWith(color: AppColors.primary),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          CustomTextField(
            text: 'الأسم الكامل',
            controller: usernameController,
            textInputType: TextInputType.emailAddress,
            prefixIcon: Icons.person,
          ),
          CustomTextField(
            text: 'البريد الإلكتروني',
            controller: emailController,
            prefixIcon: Icons.email_outlined,
          ),
          CustomTextField(
            text: 'كلمة المرور',
            controller: passwordController,
            prefixIcon: Icons.lock,
            suffixIconButton: IconButton(
              onPressed: () {},
              icon: Icon(Icons.remove_red_eye_outlined),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          CustomButton(text: 'تسجيل حساب', onTap: () {}),
        ],
      ),
    );
  }
}
