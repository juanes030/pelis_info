import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'analytics_service.dart';
import 'firebase_analytics_service.dart';

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return FirebaseAnalyticsService(FirebaseAnalytics.instance);
});
