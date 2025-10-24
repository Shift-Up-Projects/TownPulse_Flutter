// lib/features/profile/presentation/view/update_password_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/core/widgets/showToast.dart';
import 'package:town_pulse2/features/auth/data/repo/auth_repo_Impl.dart';
import 'package:town_pulse2/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/create_button.dart';
import 'package:town_pulse2/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:town_pulse2/features/profile/presentation/cubit/profile_state.dart';

class UpdatePasswordView extends StatefulWidget {
  const UpdatePasswordView({super.key});

  @override
  State<UpdatePasswordView> createState() => _UpdatePasswordViewState();
}

class _UpdatePasswordViewState extends State<UpdatePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void _submitUpdate(BuildContext cubitContext) {
    if (_formKey.currentState!.validate()) {
      if (newPasswordController.text != confirmPasswordController.text) {
        ShowToast(
          message: 'كلمة المرور الجديدة وتأكيدها غير متطابقين',
          state: toastState.error,
        );
        return;
      }

      ProfileCubit.get(cubitContext).updatePassword(
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(AuthRepoImpl()),
      child: Scaffold(
        appBar: AppBar(title: const Text('تغيير كلمة المرور')),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is PasswordUpdateSuccess) {
              ShowToast(message: state.message, state: toastState.success);

              Navigator.pop(context);
            } else if (state is PasswordUpdateError) {
              ShowToast(
                message: 'فشل التحديث: ${state.message}',
                state: toastState.error,
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is PasswordUpdating;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      text: 'كلمة المرور الحالية',
                      prefixIcon: Icons.lock_outline,
                      controller: currentPasswordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      text: 'كلمة المرور الجديدة',
                      prefixIcon: Icons.lock,
                      controller: newPasswordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      text: 'تأكيد كلمة المرور الجديدة',
                      prefixIcon: Icons.lock_open,
                      controller: confirmPasswordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),
                    CreateButton(
                      loading: isLoading,
                      onPressed: () => _submitUpdate(context),
                      text: 'تغيير كلمة المرور',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
