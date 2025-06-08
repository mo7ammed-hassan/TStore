import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:t_store/app.dart';
import 'package:t_store/common/core/bloc/bloc_observier.dart';
import 'package:t_store/common/core/hive_boxes/open_boxes.dart';
import 'package:t_store/common/cubits/launch_app/launch_app_cubit.dart';
import 'package:t_store/features/shop/features/cart/data/models/cart_item_model.dart';
import 'package:t_store/features/shop/features/home/domain/entites/category_entity.dart';
import 'package:t_store/features/shop/features/wishlist/data/model/wishlist_model.dart';
import 'package:t_store/firebase_options.dart';
import 'package:t_store/service_locator.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  // Run the app inside a Zone to catch uncaught errors
  runZonedGuarded<Future<void>>(
    () async {
      // Ensure Flutter bindings are initialized
      final WidgetsBinding widgetsBinding =
          WidgetsFlutterBinding.ensureInitialized();
      widgetsBinding.addObserver(AppLifecycleObserver());

      // Hive Initialization
      await Hive.initFlutter();

      // Register Adapters with duplicate check
      if (!Hive.isAdapterRegistered(CategoryEntityAdapter().typeId)) {
        Hive.registerAdapter(CategoryEntityAdapter());
      }
      if (!Hive.isAdapterRegistered(WishlistModelAdapter().typeId)) {
        Hive.registerAdapter(WishlistModelAdapter());
      }

      if (!Hive.isAdapterRegistered(CartItemModelAdapter().typeId)) {
        Hive.registerAdapter(CartItemModelAdapter());
      }

      // Splash Screen
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      // Firebase Initialization
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // GetX Local Storage Initialization
      await GetStorage.init();

      // Service Locator Initialization
      await initializeDependencies();

      // Open Hive Boxes
      await OpenBoxes().initializeUserBox();

      // Remove Splash Screen after initialization
      FlutterNativeSplash.remove();

      // Bloc Observer
      Bloc.observer = MyBlocObserver();

      // Run 
      runApp(
        BlocProvider(
          create: (context) => LaunchAppCubit()..launchApp(),
          child: const MyApp(),
        ),
      );
    },
    (error, stackTrace) {
      // Catch and log uncaught errors
      FlutterError.dumpErrorToConsole(
        FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
        ),
      );
    },
  );
}
