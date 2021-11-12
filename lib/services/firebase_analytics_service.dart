import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class FirebaseAnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future<void> setCurrentPage({required String page}) async {
    await _analytics.setCurrentScreen(screenName: page);
  }

  Future<void> logEvent({required String eventName, Map<String, Object?>? params}) async {
    return await _analytics.logEvent(name: eventName, parameters: params);
  }
}