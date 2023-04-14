import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '../models/dogimage_model.dart';

class ApiServices {
  String endpoint = "https://dog.ceo/api/breeds/image/random";
  Future<List<DogImage>> getImg() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['message'];
      return result.map((e) => DogImage.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

final dogProvider = Provider<ApiServices>((ref) => ApiServices());
