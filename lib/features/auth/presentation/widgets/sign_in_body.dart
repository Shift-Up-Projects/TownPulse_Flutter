
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:town_pulse2/core/router/app_router.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/core/utils/styles.dart';
import 'package:town_pulse2/core/widgets/custom_loading_indactor.dart';
import 'package:town_pulse2/core/widgets/showToast.dart';
import 'package:town_pulse2/features/auth/data/repo/auth_repo_Impl.dart';
import 'package:town_pulse2/features/auth/presentation/manger/user_login_cubit/user_login_cubit.dart';
import 'package:town_pulse2/features/auth/presentation/widgets/custom_button.dart';
import 'package:town_pulse2/features/auth/presentation/widgets/custom_text_field.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({super.key});

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  var formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserLoginCubit(AuthRepoImpl()),
      child: BlocConsumer<UserLoginCubit, UserLoginState>(
        listener: (context, state) {
          CheckUserLogin(state);
          if (state is UserLoginSuccessfullyState) {
            Future.microtask(() {
              context.go(AppRouter.homeScreen);
            });
          }
        },
        builder: (context, state) {
          var cubit = UserLoginCubit.get(context);
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 50.0,
            ),
            child: Form(
              autovalidateMode: autovalidateMode,
              key: formKey,
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
                    style: Styles.textStyle30.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text(
                    'نبض المدينة بين يديك',
                    style: Styles.textStyle16,
                    textAlign: TextAlign.center,
                  ),
                  CustomTextField(
                    text: 'البريد الإلكتروني',
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.go(AppRouter.forgetPasswordScreen);
                        },
                        child: Text('نسيت كلمة المرور؟'),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  if (state is UserLoginLoadingState)
                    const CustomLoadingIndicator(),
                  if (state is! UserLoginLoadingState)
                    CustomButton(
                      text: 'تسجيل الدخول',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          cubit.userLogin(
                            userName: emailController.text,
                            password: passwordController.text,
                          );
                        } else {
                          autovalidateMode = AutovalidateMode.always;
                        }
                        setState(() {});
                      },
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'ليس لديك حساب؟',
                        style: Styles.textStyle16,
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: () {
                          context.go(AppRouter.signUpScreen);
                        },
                        child: Text('إنشاء حساب'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void CheckUserLogin(UserLoginState state) {
    if (state is UserLoginSuccessfullyState) {
      ShowToast(message: state.message, state: toastState.success);
    }
    if (state is UserLoginFailureState) {
      String errorMessage = state.errorMessage;
      ShowToast(message: errorMessage, state: toastState.error);
    }
  }
}
