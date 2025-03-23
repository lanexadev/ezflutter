import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateService {
  static const String apiUrl = 'https://api.example.com/version';

  static Future<bool> isUpdateAvailable(String currentVersion) async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        String latestVersion = jsonDecode(response.body)['latest_version'];
        return latestVersion != currentVersion;
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}
