abstract class AnalyticsService {
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  });

  Future<void> logScreenView({required String screenName});
}
