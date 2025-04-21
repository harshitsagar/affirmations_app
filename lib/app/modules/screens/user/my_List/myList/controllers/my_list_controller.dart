import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:affirmations_app/app/modules/screens/user/home/controllers/home_controller.dart';

class MyListController extends GetxController {
  final lists = <String>['Favorites'].obs;
  final selectedList = RxString('Favorites');
  final favoriteAffirmations = <String>[].obs;
  final customListsAffirmations = <String, List<String>>{}.obs;
  final _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  @override
  void onReady() {
    super.onReady();
    _syncFavorites();
  }


  void _initializeData() {
    // Load custom lists from storage
    final savedLists = _storage.read<List>('customLists');
    if (savedLists != null) {
      lists.addAll(savedLists.whereType<String>().where((list) => list != 'Favorites' && !lists.contains(list)));
    }

    // Load custom lists affirmations data
    final savedCustomListsData = _storage.read<Map>('customListsData');
    if (savedCustomListsData != null) {
      customListsAffirmations.assignAll(
          Map<String, List<String>>.from(
            savedCustomListsData.map(
                  (key, value) => MapEntry(key as String, List<String>.from(value)),
            ),)
          );
      }

          // Initialize favorites from HomeController
          _syncFavorites();

      // Set up auto-saving
      ever(lists, (List<String> newLists) {
        _storage.write('customLists', newLists.where((list) => list != 'Favorites').toList());
      });

      ever(customListsAffirmations, (Map<String, List<String>> newData) {
        _storage.write('customListsData', newData);
      });
    }

  void _syncFavorites() {
    favoriteAffirmations.assignAll(Get.find<HomeController>().favoriteAffirmations);

    ever(Get.find<HomeController>().favoriteAffirmations, (List<String> newFavorites) {
      favoriteAffirmations.assignAll(newFavorites);
      update();
    });
  }

  void addNewList(String listName) {
    if (listName.isNotEmpty && !lists.contains(listName)) {
      lists.add(listName);
      customListsAffirmations[listName] = [];
      selectedList.value = listName;
    }
  }

  void updateFavorites(List<String> favorites) {
    favoriteAffirmations.assignAll(favorites);
    update();
  }

  int getItemCount(String listName) {
    if (listName == 'Favorites') {
      return favoriteAffirmations.length;
    }
    return customListsAffirmations[listName]?.length ?? 0;
  }

  void navigateToList(String listName) {
    selectedList.value = listName;
    if (listName == 'Favorites') {
      Get.toNamed(Routes.FAVORITES, arguments: favoriteAffirmations.toList());
    } else {
      Get.toNamed(Routes.ADD_AFFIRMATIONS, arguments: {
        'listName': listName,
        'affirmations': customListsAffirmations[listName] ?? [],
      });
    }
  }

  void addAffirmationToList(String listName, String affirmation) {
    if (!customListsAffirmations.containsKey(listName)) {
      customListsAffirmations[listName] = [];
    }
    customListsAffirmations[listName]!.add(affirmation);
    update();
    _saveAffirmationsForList(listName); // Save to storage
  }

  void removeAffirmationFromList(String listName, String affirmation) {
    if (customListsAffirmations.containsKey(listName)) {
      customListsAffirmations[listName]!.remove(affirmation);
      update();
      _saveAffirmationsForList(listName); // Save to storage
    }
  }

  void _saveAffirmationsForList(String listName) {
    if (customListsAffirmations.containsKey(listName)) {
      _storage.write('${listName}_affirmations', customListsAffirmations[listName]);
    }
  }

  List<String>? getAffirmationsForList(String listName) {
    if (listName == 'Favorites') return favoriteAffirmations;
    return customListsAffirmations[listName];
  }

  void _saveFavorites() {
    _storage.write('favorites', favoriteAffirmations.toList());
  }

  void deleteList(String listName) {

    lists.remove(listName);
    customListsAffirmations.remove(listName);
    _storage.remove('${listName}_affirmations');

    // Update storage
    _storage.write('customLists', lists.where((list) => list != 'Favorites').toList());
    _storage.write('customListsData', customListsAffirmations);

    update();
  }

  @override
  void onClose() {
    _saveFavorites();
    super.onClose();
  }

}