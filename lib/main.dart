import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/models/dogimage_model.dart';
import 'data_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: RiverpodHome());
  }
}

class RiverpodHome extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final _data = ref.watch(dogImageProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text('Riverpod DogImage Example'),
        ),
        body: _data.when(
          data: (_data){
            List<DogImage> imageList = _data.map((e) => e).toList();
            return Column(
              children: [
                Image.network(imageList[0].message),
              ],
            );
          }, 
          error: (err, s) => Text(err.toString()), 
          loading: () => const Center(child: CircularProgressIndicator())));
  }
}
