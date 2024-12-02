class ApiConfig {
  // Base URL
  static const String baseUrl = 'http://10.250.25.39:8080/api';
  
  // API Endpoints
  static const String login = '/login';
  static const String register = '/register';
  static const String transactions = '/transactions';
  
  // API Timeout
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  
  // Headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}