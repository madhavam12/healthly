class ApiService {
  static const String apiKey = String.fromEnvironment(
      '0bee030cf09f4ae4bd7146c4776ed52e',
      defaultValue: '');
  // static const String apiKey = "0bee030cf09f4ae4bd7146c4776ed52e";
  final String _newsUrl = "http://newsapi.org/v2/everything?";
  final String _statsUrl = "https://disease.sh/v2/";
  final String _query = "q=covid%2021%20vaccine";
  final String _query2 = "q=health%fitness%20yoga%202021%20doctor%20research";
  final String _limit = "pageSize=10&page=1";

  String get query => _query;

  String get query2 => _query2;
  String get newsUrl => _newsUrl;
  String get statsUrl => _statsUrl;
  String get limit => _limit;
}
