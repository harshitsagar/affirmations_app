import 'package:affirmations_app/app/modules/screens/user/my_List/myList/views/addNewList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/my_list_controller.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:affirmations_app/app/data/components/images_path.dart';

class MyListView extends GetView<MyListController> {
  const MyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage2),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              children: [
                CustomAppBar(
                  title: 'My Lists',
                  onBackPressed: () => Get.back(),
                ),

                SizedBox(height: 20.h),

                Expanded(
                  child: Obx(
                        () => ListView.separated(
                      itemCount: controller.lists.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final listName = controller.lists[index];
                        return _buildListItem(listName, controller);
                      },
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.bottomSheet(
                        AddNewList(),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        barrierColor: Colors.black.withOpacity(0.5),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      'New List',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // In my_list_view.dart, update the _buildListItem widget:
  Widget _buildListItem(String listName, MyListController controller) {
    return GestureDetector(
      onTap: () => controller.navigateToList(listName),
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                listName,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Obx(() => Text(
                  "${controller.getItemCount(listName)} Items",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                )),
                SizedBox(width: 10.w),
                Icon(Icons.chevron_right, size: 24.w),
              ],
            )
          ],
        ),
      ),
    );
  }
}