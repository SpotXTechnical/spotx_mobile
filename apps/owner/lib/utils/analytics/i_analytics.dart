
abstract class IAnalytics{
  Future<void> setUserId(String id);
  Future<void> setUserProperty({required String name, required String value});
  Future<void> logEvent({required String name, Map<String, dynamic>? parameters});
}