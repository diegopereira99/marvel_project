import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel_test/app_bindings.dart';
import 'package:marvel_test/app_routes.dart';
import 'package:marvel_test/internacionalization/app_internacionalization.dart';
import 'package:marvel_test/services/firebase_analytics_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppBindigs().dependencies();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marvel Test',
      translations: AppTranslation(),
      locale: const Locale('pt_BR'),
      fallbackLocale: const Locale('pt_BR'),
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.grey[800],
        appBarTheme: const AppBarTheme(
          color: Colors.red,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600
          )
        )
      ),
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.routes,
      navigatorObservers: [Get.put(FirebaseAnalyticsService()).getAnalyticsObserver()],
    );
  }
}


