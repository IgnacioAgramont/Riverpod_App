import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/dogimage_model.dart';

class DogNotifier extends StateNotifier<String> {
  DogNotifier() : super('');
  
  String endpoint = "https://dog.ceo/api/breeds/image/random";
  Future<void> getImg() async {
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body)['message'];
      //final List result = jsonDecode(response.body)['message'];
      //return result.map((e) => DogImage.fromJson(e)).toList();
      state = json;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

final dogProvider = StateNotifierProvider<DogNotifier, String>((ref) => DogNotifier());
