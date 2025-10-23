// lib/features/profile/presentation/view/profile_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:town_pulse2/core/router/app_router.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/core/utils/styles.dart';
import 'package:town_pulse2/core/widgets/shimmer_loading.dart';
import 'package:town_pulse2/features/auth/data/repo/auth_repo_Impl.dart';
import 'package:town_pulse2/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:town_pulse2/features/profile/presentation/cubit/profile_state.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(AuthRepoImpl())..fetchCurrentUser(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLogoutSuccess) {
            context.go(AppRouter.signInScreen);
          }
          if (state is ProfileError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading || state is ProfileUpdating) {
            return const Center(child: ShimmerLoading());
          }

          final user = (state is ProfileLoaded) ? state.user : null;
          final currentLoadedUser = (state is ProfileUpdateSuccess)
              ? state.user
              : user;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.bgSecondary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.primary,
                        child: Text(
                          currentLoadedUser?.name.isNotEmpty == true
                              ? currentLoadedUser!.name[0].toUpperCase()
                              : '?',
                          style: Styles.textStyle30.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        currentLoadedUser?.name ?? 'المستخدم',
                        style: Styles.textStyle20.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        currentLoadedUser?.email ?? 'البريد الإلكتروني',
                        style: Styles.textStyle16.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                _buildActionCard(
                  context,
                  title: 'تعديل الملف الشخصي',
                  icon: Icons.edit,
                  onTap: () async {
                    if (currentLoadedUser != null) {
                      final result = await context.push(
                        AppRouter.updateProfileView,
                        extra: currentLoadedUser,
                      );

                      if (result == true) {
                        context.read<ProfileCubit>().fetchCurrentUser();
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('لا يمكن جلب بيانات المستخدم للتعديل'),
                        ),
                      );
                    }
                  },
                ),
                _buildActionCard(
                  context,
                  title: 'تغيير كلمة المرور',
                  icon: Icons.lock_reset,
                  onTap: () => context.push(AppRouter.updatePasswordView),
                ),
                _buildActionCard(
                  context,
                  title: 'تسجيل الخروج',
                  icon: Icons.logout,
                  color: AppColors.error,
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('تأكيد تسجيل الخروج'),
                        content: const Text(
                          'هل أنت متأكد من رغبتك في تسجيل الخروج؟',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('إلغاء'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.go(AppRouter.signInScreen);
                              ProfileCubit.get(context).userLogout();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.error,
                            ),
                            child: const Text('خروج'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color color = AppColors.textPrimary,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: AppColors.bgTertiary, // استخدام لون أغمق للبطاقة
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: TextStyle(color: color)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
