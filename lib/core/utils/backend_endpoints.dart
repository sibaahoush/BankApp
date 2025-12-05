abstract class BackendEndPoint {
  static const String url = 'http://10.0.2.2:8000';
  static const String signIn = '/api/auth/login';
  static const String signUp = '/api/auth/register';
  static const String signOut = '/api/auth/logout';
  static const String refresh = '/api/auth/refresh';
}
