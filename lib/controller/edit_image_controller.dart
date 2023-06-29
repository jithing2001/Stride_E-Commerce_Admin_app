import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditImgController extends GetxController {
  RxString pickedImg = ''.obs;

  changeImg() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      pickedImg.value = pickedImage.path;
    }
  }
}
