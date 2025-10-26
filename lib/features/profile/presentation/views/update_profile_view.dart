import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/core/widgets/showToast.dart';
import 'package:town_pulse2/features/auth/data/model/user_model.dart';
import 'package:town_pulse2/features/auth/data/repo/auth_repo_Impl.dart';
import 'package:town_pulse2/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/create_button.dart';
import 'package:town_pulse2/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:town_pulse2/features/profile/presentation/cubit/profile_state.dart';

class UpdateProfileView extends StatefulWidget {
  final User user;
  const UpdateProfileView({super.key, required this.user});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
  }

  void _submitUpdate(BuildContext cubitContext) {
    if (_formKey.currentState!.validate()) {
      ProfileCubit.get(cubitContext).updateProfile(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(AuthRepoImpl()),
      child: Scaffold(
        appBar: AppBar(title: const Text('تعديل الملف الشخصي')),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdateSuccess) {
              ShowToast(
                message: 'تم تحديث البيانات بنجاح ',
                state: toastState.success,
              );
              Navigator.pop(context, true);
            } else if (state is ProfileUpdateError) {
              ShowToast(message: state.message, state: toastState.error);
            }
          },
          builder: (context, state) {
            final isLoading = state is ProfileUpdating;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      text: 'الاسم الكامل',
                      prefixIcon: Icons.person,
                      controller: nameController,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      text: 'البريد الإلكتروني',
                      prefixIcon: Icons.email,
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 30),
                    CreateButton(
                      loading: isLoading,
                      onPressed: () => _submitUpdate(context),
                      text: 'حفظ التعديلات',
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
