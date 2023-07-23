import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditImgController extends GetxController {
  RxString pickedImg = ''.obs;
  RxInt selectedIndex = 0.obs;

  List<String> pickedImages = List.generate(3, (_) => '');

  changeImg(int index) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      pickedImages[index] = pickedImage.path;
      update();
    }
  }

  changeIndex(int index) {
    selectedIndex.value = index;
    pickedImg.value = '';
  }
}
