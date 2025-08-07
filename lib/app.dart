
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:t_store/app_entry_point.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/service_locator.dart';
import 'package:t_store/utils/popups/loaders.dart';
import 'package:t_store/utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => getIt<CartCubit>()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'T-Store',
        themeMode: ThemeMode.system,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        navigatorKey: AppContext.navigatorKey,
        home: const AppEntryPoint(),
      ),
    );
  }
}
