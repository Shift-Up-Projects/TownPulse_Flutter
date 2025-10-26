import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:town_pulse2/core/router/app_router.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/core/utils/styles.dart';
import 'package:town_pulse2/core/widgets/custom_loading_indactor.dart';
import 'package:town_pulse2/core/widgets/showToast.dart';
import 'package:town_pulse2/features/auth/data/repo/auth_repo_Impl.dart';
import 'package:town_pulse2/features/auth/presentation/manger/user_Register_cubit/user_register_cubit.dart';
import 'package:town_pulse2/features/auth/presentation/widgets/custom_button.dart';
import 'package:town_pulse2/features/auth/presentation/widgets/custom_text_field.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserRegisterCubit(AuthRepoImpl()),
      child: BlocConsumer<UserRegisterCubit, UserRegisterState>(
        listener: (context, state) => _checkUserRegister(context, state),
        builder: (context, state) {
          var cubit = UserRegisterCubit.get(context);
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 50.0,
            ),
            child: Form(
              key: formKey,
              autovalidateMode: autovalidateMode,
              child: ListView(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  const CircleAvatar(
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
                  CustomTextField(
                    text: 'الأسم الكامل',
                    controller: usernameController,
                    textInputType: TextInputType.name,
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
                      icon: const Icon(Icons.remove_red_eye_outlined),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  if (state is UserRegisterLoadingState)
                    const CustomLoadingIndicator(),
                  if (state is! UserRegisterLoadingState)
                    CustomButton(
                      text: 'تسجيل حساب',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          cubit.userRegister(
                            email: emailController.text,
                            userName: usernameController.text,
                            password: passwordController.text,
                          );
                        } else {
                          setState(() {
                            autovalidateMode = AutovalidateMode.always;
                          });
                        }
                      },
                    ),
                  TextButton(
                    onPressed: () {
                      context.go(AppRouter.signInScreen);
                    },
                    child: Text('العودة لشاشة تسجيل الدخول '),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _checkUserRegister(BuildContext context, UserRegisterState state) {
    if (state is UserRegisterSuccessfullyState) {
      ShowToast(message: state.message, state: toastState.success);

      context.go(AppRouter.homeScreen);
    }

    if (state is UserRegisterFailureState) {
      ShowToast(message: state.errorMessage, state: toastState.error);
    }
  }
}
