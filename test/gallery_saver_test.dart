import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';

void main() {
  // Ensure test binding is initialized once and reuse its defaultBinaryMessenger.
  final binding = TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('gallery_saver');

  setUp(() {
    // Use the binding's defaultBinaryMessenger to set mock handlers.
    binding.defaultBinaryMessenger.setMockMethodCallHandler(channel,
        (MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'saveImage':
          return true;
        case 'saveVideo':
          return false;
      }
      return 'unknown method';
    });
  });

  tearDown(() {
    binding.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('save image', () async {
    expect(await GallerySaver.saveImage('/storage/emulated/image.jpg'), true);
  });

  test('save video', () async {
    expect(await GallerySaver.saveVideo('/storage/emulated/video.mov'), false);
  });
}
