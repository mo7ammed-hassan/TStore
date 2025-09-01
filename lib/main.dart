import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:t_store/app.dart';
import 'package:t_store/bloc_observier.dart';
import 'package:t_store/common/core/hive_boxes/open_boxes.dart';
import 'package:t_store/common/cubits/launch_app/launch_app_cubit.dart';
import 'package:t_store/firebase_options.dart';
import 'package:t_store/config/service_locator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/utils/helpers/register_adapters.dart';

void main() {
  // Run the app inside a Zone to catch uncaught errors
  runZonedGuarded<Future<void>>(
    () async {
      // Ensure Flutter bindings are initialized
      final WidgetsBinding widgetsBinding =
          WidgetsFlutterBinding.ensureInitialized();
      widgetsBinding.addObserver(AppLifecycleObserver());

      //debugPrintRebuildDirtyWidgets = true;

      // Hive Initialization
      await Hive.initFlutter();
      rgisterAdapters();

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

      // Run the app
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

class AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      // Cleanup resources when the app is closed
      getIt.reset(dispose: true); // Ensure proper resource disposal
    }
  }
}
