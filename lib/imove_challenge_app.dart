import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:imove_challenge/router/service_locator/app_router_di_extensions.dart';

import 'core/theme/app_theme.dart';

class IMoveChallengeApp extends StatefulWidget {
  const IMoveChallengeApp({super.key});

  @override
  State<IMoveChallengeApp> createState() => _IMoveChallengeAppState();
}

class _IMoveChallengeAppState extends State<IMoveChallengeApp> {
  final GetIt getIt = GetIt.instance;
  late final appRouter = getIt.appRouter.router;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      useInheritedMediaQuery: true,
      builder: (context, child) => MaterialApp.router(
        routerConfig: appRouter,
        title: 'iMove interview challenge',
        theme: appTheme,
      ),
    );
  }
}
