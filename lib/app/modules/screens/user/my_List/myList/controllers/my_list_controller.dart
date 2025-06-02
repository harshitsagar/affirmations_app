import 'package:affirmations_app/app/helpers/constants/api_constants.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:affirmations_app/app/modules/screens/user/home/controllers/home_controller.dart';

import '../../../../../../data/api_provider.dart';
import '../../../../../../data/config.dart';
import '../../../../../../data/models/affirmation_list_model.dart';
import '../../../../../../helpers/services/local_storage.dart';

class MyListController extends GetxController {
  final lists = <AffirmationListModelData>[].obs; // ✅ backend-driven lists
  final selectedList = Rx<AffirmationListModelData?>(null);
  Map<String, String> listNameToIdMap = {
  };
  final affirmationTextToIdMap = <String, String>{}.obs;

  final loadingStatus = LoadingStatus.loading.obs;


  // final lists = <String>['Favorites'].obs;
  // final selectedList = RxString('Favorites');
  final favoriteAffirmations = <String>[].obs;
  // final customListsAffirmations = <String, List<String>>{}.obs;
  final _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _syncFavorites();
    fetchListsFromBackend();
  }

  @override
  void onReady() {
    super.onReady();
    _syncFavorites();
  }




  void _syncFavorites() {
    favoriteAffirmations.assignAll(Get.find<HomeController>().favoriteAffirmations);

    ever(Get.find<HomeController>().favoriteAffirmations, (List<String> newFavorites) {
      favoriteAffirmations.assignAll(newFavorites);
      update();
    });
  }

  Future<void> fetchListsFromBackend() async {
    loadingStatus.value = LoadingStatus.loading; // Set loading status

    try {
      final accessToken = LocalStorage.getUserAccessToken();

      final response = await APIProvider().postAPICall(
        ApiConstants.getAffirmationList,
        {}, // Add pagination if needed
        {
          "Authorization": accessToken,
          "Content-Type": "application/json",
        },
      );

      if (response.data['code'] == 100) {
        final model = AffirmationListModel.fromJson(response.data);
        lists.assignAll(model.data);
        // ✅ Populate listNameToIdMap
        listNameToIdMap = {
          for (var item in model.data) item.name: item.id

        };
        loadingStatus.value = LoadingStatus.completed; // Set status to completed

      } else {
        Get.snackbar("Error", response.data["message"] ?? "Failed to fetch lists.");
      }
    } catch (e) {
      print("Fetch list error: $e");
      Get.snackbar("Error", "Unable to fetch your lists.");
    }
  }




  Future<void> addNewListFromApi(String listName) async {
    if (listName.isEmpty || lists.contains(listName)) {
      Get.snackbar("Warning", "List name is empty or already exists.");
      return;
    }

    try {
      final accessToken = LocalStorage.getUserAccessToken();

      final response = await APIProvider().postAPICall(
        ApiConstants.newList,
        {"name": listName},
        {
          "Authorization": accessToken,
          "Content-Type": "application/json",
        },
      );

      if (response.data["code"] == 100) {
        // customListsAffirmations[listName] = [];
        Get.back();
        Get.snackbar("Success", "List added successfully.");
        await fetchListsFromBackend(); // 🔁 re-fetch all lists
      } else {
        Get.snackbar("Error", response.data["message"] ?? "Failed to add list.");
      }
    } catch (e) {
      print("Add list error: $e");
      Get.snackbar("Error", "Something went wrong while adding the list.");
      print("Add list error: $e");
    }
  }




  void updateFavorites(List<String> favorites) {
    favoriteAffirmations.assignAll(favorites);
    update();
  }

  int getItemCount(String listId) {
    final list = lists.firstWhereOrNull((element) => element.id == listId);
    return list?.totalAffirmation ?? 0;
  }


  void navigateToList(AffirmationListModelData listData) {
    selectedList.value = listData;

    Get.toNamed(Routes.ADD_AFFIRMATIONS, arguments: {
      'listName': listData.name,
      'listId': listData.id,
      'affirmations': listData.affirmations, // List of affirmation objects or IDs
    });
  }


  void addAffirmationToList(String listName, String affirmation) {
    // if (!customListsAffirmations.containsKey(listName)) {
    //   customListsAffirmations[listName] = [];
    // }
    // customListsAffirmations[listName]!.add(affirmation);
    // update();
    // _saveAffirmationsForList(listName); // Save to storage
  }

  void removeAffirmationFromList(String listName, String affirmation) {
    // if (customListsAffirmations.containsKey(listName)) {
    //   customListsAffirmations[listName]!.remove(affirmation);
    //   update();
    //   _saveAffirmationsForList(listName); // Save to storage
    // }
  }

  void _saveAffirmationsForList(String listName) {
    // if (customListsAffirmations.containsKey(listName)) {
    //   _storage.write('${listName}_affirmations', customListsAffirmations[listName]);
    // }
  }

  List<String>? getAffirmationsForList(String listName) {
    // if (listName == 'Favorites') return favoriteAffirmations;
    // return customListsAffirmations[listName];
  }

  void _saveFavorites() {
    _storage.write('favorites', favoriteAffirmations.toList());
  }





  Future<void> deleteList(String listName) async {
    final myListRef = listNameToIdMap[listName];
    if (myListRef == null) {
      Get.snackbar("Error", "List reference not found.");
      return;
    }

    try {
      final accessToken = LocalStorage.getUserAccessToken();

      final response = await APIProvider().postAPICall(
        ApiConstants.deleteAffirmation, // same endpoint
        {
          "myListRef": myListRef,
          "action": 1, // 1 = delete list
        },
        {
          "Authorization": accessToken,
          "Content-Type": "application/json",
        },
      );

      final res = response.data;

      if (res["code"] == 100) {
        lists.removeWhere((element) => element.name == listName);
        listNameToIdMap.remove(listName);
        update();
        Get.snackbar("Success", "List deleted successfully.");
      } else {
        Get.snackbar("Error", res["message"] ?? "Failed to delete list.");
      }
    } catch (e) {
      print("Delete List Error: $e");
      Get.snackbar("Error", "Something went wrong while deleting list.");
    }
  }


  @override
  void onClose() {
    _saveFavorites();
    super.onClose();
  }

}