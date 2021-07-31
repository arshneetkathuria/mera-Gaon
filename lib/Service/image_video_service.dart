
import 'package:image_picker/image_picker.dart';

class ImageVideoService{

  static final picker = new ImagePicker();

  static takePicture() async {
    try {
      await picker
          .pickImage(source: ImageSource.camera)
          .then((recordedImage) async {
        if (recordedImage != null && recordedImage.path != null) {
         print("recorded image path==${recordedImage.path}");
        }
          });
    } catch (e) {
      print("Error=$e");
    }
  }
}