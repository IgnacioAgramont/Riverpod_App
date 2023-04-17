import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/services/services.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: RiverpodHome());
  }
}

class RiverpodHome extends ConsumerWidget {
  const RiverpodHome({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod DogImage Example'),
      ),
      body: const Center(child: DogImageWidget()),
    );
  }
}

class DogImageWidget extends StatefulWidget {
  const DogImageWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DogImageWidgetState createState() => _DogImageWidgetState();
}

class _DogImageWidgetState extends State<DogImageWidget> {
  bool _isFirstBuild = true;

  void _getDogImage(WidgetRef ref) {
    ref.read(dogProvider.notifier).getImg();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
      if (_isFirstBuild) {
        _getDogImage(ref);
        _isFirstBuild = false;
      }

      final imageUrl = ref.watch(dogProvider);
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imageUrl.isNotEmpty)
            Flexible(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            )
          else
            const CircularProgressIndicator(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _getDogImage(ref),
            child: const Text('Reload Image'),
          ),
        ],
      );
    });
  }
}
