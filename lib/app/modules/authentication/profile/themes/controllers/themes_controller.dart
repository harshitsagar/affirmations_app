import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:get/get.dart';

class ThemesController extends GetxController {

  final List<String> themeImages = [
    theme1,
    theme2,
    theme3,
  ];

  var selectedTheme = 0.obs;

  void selectTheme(int index) {
    selectedTheme.value = index;
  }

}
