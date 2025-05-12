abstract class IHttpClient {
  Future<Map<String, dynamic>> get(String url);
}
