abstract class AuthLocalDataSource {
  Future<void> setToken(String token);
  Future<String> getToken();
  Future<void> clearToken();
}