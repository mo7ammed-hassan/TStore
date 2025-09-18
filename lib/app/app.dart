import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/app/app_entry_point.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/core/config/service_locator.dart';
import 'package:t_store/core/utils/helpers/app_focus_handler.dart';
import 'package:t_store/core/utils/popups/loaders.dart';
import 'package:t_store/core/utils/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => getIt<CartCubit>()),
      ],
      child: AppFocusHandler(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'T-Store',
          themeMode: ThemeMode.system,
          theme: AppTheme.lightTheme(context),
          darkTheme: AppTheme.darkTheme(context),
          navigatorKey: AppContext.navigatorKey,
          home: const AppEntryPoint(),
        ),
      ),
    );
  }
}
