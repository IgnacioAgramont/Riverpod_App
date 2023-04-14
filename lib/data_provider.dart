import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/models/dogimage_model.dart';
import 'package:riverpod_app/services/services.dart';

final dogImageProvider = FutureProvider<List<DogImage>>((ref) async {
  final dogImage = await ref.watch(dogProvider).getImg();
  return dogImage;
});