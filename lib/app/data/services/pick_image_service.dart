import 'package:image_picker/image_picker.dart';

class PickImageService {
  /// Pick an image from the user's device.
  ///
  /// This method returns a [Future] that resolves to an [XFile] if the user
  /// selects an image. If the user cancels the image selection, the returned
  /// [Future] resolves to `null`.
  ///
  /// The image is picked from the user's device gallery, and the returned [XFile]
  /// contains the path to the selected image.
  Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }
}
