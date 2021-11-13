import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class ApplicationLogService {
  static Future<void> createLog(
      {required dynamic error, StackTrace? stackTrace, dynamic reason}) async {
    await FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      reason: reason,
    );
  }
}
