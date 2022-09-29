import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gifs/Models/Model_Gifs.dart';

class GifProvider {
  final url =
      "https://api.giphy.com/v1/gifs/trending?api_key=eXhxC0EgfrC9cn2dfITnajOQi3iX11WI&limit=10&rating=g&offset=";

  Future<List<ModelGifs>> getGifs(int page) async {
    final resp = await http.get(Uri.parse('$url$page'));
    if (resp.statusCode == 200) {
      String body = utf8.decode(resp.bodyBytes);
      final jsonData = jsonDecode(body);
      final gifs = Gifs.fromJsonList(jsonData);
      return gifs.items;
    } else {
      throw Exception("Ocurrio Algo ${resp.statusCode}");
    }
  }
}
