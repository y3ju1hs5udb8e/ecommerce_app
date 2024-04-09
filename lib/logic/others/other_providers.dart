import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

//image
final imagePickerProvider = NotifierProvider<ImageNotifier, XFile?>(
  () => ImageNotifier(),
);

class ImageNotifier extends Notifier<XFile?> {
  @override
  XFile? build() {
    return null;
  }

  void galleryImage() async {
    final ImagePicker picker = ImagePicker();
    state = await picker.pickImage(source: ImageSource.gallery);
  }
}

//theme
final themeProvider = NotifierProvider<ThemProvider, bool>(
  () => ThemProvider(),
);

class ThemProvider extends Notifier<bool> {
  @override
  bool build() {
    final box = Hive.box('data').get('bool');
    return box ?? true;
  }

  void toogle() {
    state = !state;

    final box = Hive.box('data');
    box.put('bool', state);
  }
}
