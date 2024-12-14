import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:taga_cuyo/core/models/translate_model.dart';
import 'package:taga_cuyo/core/utils/Logger.dart';

class TranslateApi {
  final String apiUrl =
      "https://taga-cuyo-translator-598478516019.asia-southeast1.run.app/translate";

  Future<String> translate(TranslationRequest request) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(request.toJson()), // Use the model's toJson method
      );

      // Log the response to debug
      Logger.log('Response status: ${response.statusCode}');
      Logger.log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["translated_sentence"] ?? "Translation failed";
      } else {
        return "Error: ${response.statusCode}";
      }
    } catch (e) {
      return "Error: $e";
    }
  }
}
