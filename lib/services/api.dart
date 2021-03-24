import 'package:http/http.dart' as http;

class ApiService {
  /// This service should be handled as a singleton, as to not have multiple versions of the http client running
  final client = http.Client();

  Future<String> getApiData(String url) async {
    try {
      var uriResponse = await client.get(Uri.parse(url));
      return uriResponse.body;
    } finally {
      client.close();
    }
  }
}
