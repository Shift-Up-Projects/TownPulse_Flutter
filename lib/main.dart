import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/core/helper/CachHepler.dart';
import 'package:town_pulse2/core/router/app_router.dart';
import 'package:town_pulse2/core/utils/api_services.dart';
import 'package:town_pulse2/core/utils/app_theme.dart';
import 'package:town_pulse2/features/activity/data/datasource/acitivity_remote_data_source.dart';
import 'package:town_pulse2/features/activity/data/repo/activity_repo.dart';
import 'package:town_pulse2/features/activity/data/repo/activity_repo_impl.dart';
import 'package:town_pulse2/features/activity/presentation/cubit/activity_cubit.dart';
import 'package:town_pulse2/features/auth/presentation/view/forget_password_view.dart';
import 'package:town_pulse2/features/home/presentation/views/home_view.dart';
// import 'package:town_pulse2/features/splash/presentation/
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:town_pulse2/features/intro/presentation/view/intro_view.dart';
import 'package:town_pulse2/features/splash/presentation/view/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Api.init();
  runApp(TownPulse());
}

class TownPulse extends StatelessWidget {
  const TownPulse({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ActivityCubit(ActivityRepoImpl(AcitivityRemoteDataSource()))
            ..fetchAllActivity(),
      child: MaterialApp.router(
        theme: AppThemes.darkTheme,
        debugShowCheckedModeBanner: false,
        locale: const Locale('ar', 'EG'),
        supportedLocales: const [Locale('ar', 'EG'), Locale('en', 'US')],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        // home: HomeView(),

        // theme: ThemeData.dark(),
        // themeMode: ThemeMode.light,
        // debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
