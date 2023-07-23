import 'package:get/get.dart';

class ImageAddNotifier extends GetxController {
  List<String> imageList = [];
  int? selectedIndex;

  imageAdd({required String imagePath, required int index}) {
    imageList.add(imagePath);
    selectedIndex = index;
    update();
  }

  changeIndex({required int index}) {
    selectedIndex = index;
    update();

  }

  imageRemove({required int imageIndex}) {
    imageList.removeAt(imageIndex);
    update();

  }
}
