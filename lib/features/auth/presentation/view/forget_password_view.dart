import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:town_pulse2/core/router/app_router.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/core/utils/styles.dart';
import 'package:town_pulse2/core/widgets/custom_loading_indactor.dart';
import 'package:town_pulse2/core/widgets/showToast.dart';
import 'package:town_pulse2/features/auth/data/repo/auth_repo_Impl.dart';
import 'package:town_pulse2/features/auth/presentation/manger/forget_password_cubit/forgot_password_cubit.dart';
import 'package:town_pulse2/features/auth/presentation/widgets/custom_button.dart';
import 'package:town_pulse2/features/auth/presentation/widgets/custom_text_field.dart'
    show CustomTextField;

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState?.validate() == true) {
      ForgotPasswordCubit.get(
        context,
      ).forgotPassword(email: emailController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(AuthRepoImpl()),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            ShowToast(message: state.message, state: toastState.success);
            Future.delayed(const Duration(seconds: 2), () {
              context.go(AppRouter.signInScreen);
            });
          } else if (state is ForgotPasswordError) {
            ShowToast(message: state.message, state: toastState.error);
          }
        },
        builder: (context, state) {
          final isLoading = state is ForgotPasswordLoading;

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      maxRadius: 50,
                      child: Icon(Icons.key_outlined, size: 50),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'نسيت كلمة المرور ',
                      style: Styles.textStyle30.copyWith(
                        color: AppColors.primary,
                      ),
                    ),

                    Text(
                      'ادخل بريدك الالكتروني و سنرسل لك رابطاً \nلاعادة تعيين كلمة المرور  ',
                      style: Styles.textStyle18,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),

                    CustomTextField(
                      controller: emailController,
                      text: 'البريد الالكتروني',
                      prefixIcon: Icons.email_outlined,
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20),

                    if (isLoading) const CustomLoadingIndicator(),
                    if (!isLoading)
                      CustomButton(text: 'ارسال رابط الاعادة', onTap: _submit),

                    TextButton(
                      onPressed: () {
                        context.go(AppRouter.signInScreen);
                      },
                      child: Text('العودة لتسجيل الدخول'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
