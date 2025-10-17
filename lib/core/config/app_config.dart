class AppConfig {
  AppConfig._();

  // Base URLs
  static const String baseUrl = 'https://frijo.noviindus.in';
  
  // API Endpoints
  static const String loginEndpoint = '/api/otp_verified';
  static const String categoryListEndpoint = '/api/category_list';
  static const String homeEndpoint = '/api/home';
  static const String myFeedEndpoint = '/api/my_feed';
  static const String uploadFeedEndpoint = '/api/my_feed';
  
  // App Info
  static const String appName = 'noviindus';
  static const String appVersion = '1.0.0';
  
  // Timeouts
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  
  // Video Constraints
  static const int maxVideoDurationMinutes = 5;
  static const List<String> allowedVideoFormats = ['mp4'];
  
  // Pagination
  static const int defaultPageSize = 20;
}
