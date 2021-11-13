import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';


class FirebaseAnalyticsService {

  static FirebaseAnalyticsObserver getAnalyticsObserver() {
    return FirebaseAnalyticsObserver(analytics: FirebaseAnalytics());
  }
      
  static Future<void> setCurrentPage({required String page}) async {
    final analytics = FirebaseAnalytics();
    await analytics.setCurrentScreen(screenName: page);
  }

  static Future<void> logEvent(
      {required String eventName, Map<String, Object?>? params}) async {
    final analytics = FirebaseAnalytics();
    return await analytics.logEvent(name: eventName, parameters: params);
  }
}
