import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:t_store/app_entry_point.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';
import 'package:t_store/service_locator.dart';
import 'package:t_store/utils/popups/loaders.dart';
import 'package:t_store/utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'T-Store',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        navigatorKey: AppContext.navigatorKey,
        home: const AppEntryPoint(),
      ),
    );
  }
}

class AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      // Cleanup resources when the app is closed
      getIt.reset(); // Ensure proper resource disposal
    }
  }
}
 

 