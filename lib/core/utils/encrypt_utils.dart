import 'dart:convert';

class EncryptUtils {
  static String jsonToBase64(String jsonData) {
    String base64Encoded = base64.encode(utf8.encode(jsonData));
    return base64Encoded;
  }

  static String base64ToJson(String base64Data) {
    List<int> bytes = base64.decode(base64Data);

    String jsonDecoded = utf8.decode(bytes);
    // Map<String, dynamic> jsonData = json.decode(jsonDecoded);
    return jsonDecoded;
  }
}
