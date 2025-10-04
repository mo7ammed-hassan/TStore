import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:t_store/app/app.dart';
import 'package:t_store/core/bloc/app_bloc_observer.dart';
import 'package:t_store/core/hive_boxes/open_boxes.dart';
import 'package:t_store/core/utils/storage/app_storage.dart';
import 'package:t_store/features/payment/core/storage/payment_storage.dart';
import 'package:t_store/firebase_options.dart';
import 'package:t_store/core/config/service_locator.dart';
import 'package:t_store/core/utils/helpers/register_adapters.dart';

void main() {
  // Run the app inside a Zone to catch uncaught errors
  runZonedGuarded<Future<void>>(
    () async {
      // Ensure Flutter bindings are initialized
      final WidgetsBinding widgetsBinding =
          WidgetsFlutterBinding.ensureInitialized();
      widgetsBinding.addObserver(AppLifecycleObserver());

      // Load env file
      await dotenv.load(fileName: '.env');

      // Hive Initialization
      await Hive.initFlutter();
      rgisterAdapters();

      // Splash Screen
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      // Firebase Initialization
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // Payment Storage Initialization
      await PaymentStorage.init();

      // Service Locator Initialization
      await initializeDependencies();

      // Initialize Shared Preferences & Storage
      await getIt.get<AppStorage>().init();

      // Open Hive Boxes
      await OpenBoxes().initializeUserBox();

      // Remove Splash Screen after initialization
      FlutterNativeSplash.remove();

      // Bloc Observer
      Bloc.observer = AppBlocObserver();

      // Strip
      Stripe.publishableKey = dotenv.env['PUBLISHABLE_KEY']!;

      // Run the app
      runApp(const MyApp());
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
