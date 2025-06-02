// add_affirmations_view.dart
import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/helpers/services/themeServices.dart';
import 'package:affirmations_app/app/modules/screens/user/home/controllers/home_controller.dart';
import 'package:affirmations_app/app/modules/screens/user/my_List/add_affirmations/views/addAffirmation_bottomsheet.dart';
import 'package:affirmations_app/app/modules/screens/user/my_List/add_affirmations/views/deletePopupScreen.dart';
import 'package:affirmations_app/app/modules/screens/user/my_List/myList/controllers/my_list_controller.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/add_affirmations_controller.dart';

class AddAffirmationsView extends GetView<AddAffirmationsController> {
  const AddAffirmationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(bgImage2),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        decoration: ThemeService.getBackgroundDecoration(),
        child: SafeArea(
          child: Column(
            children: [

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: CustomAppBar(
                  title: controller.listName.value,
                  onBackPressed: () => Get.back(),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {
                        Get.dialog(
                          DeletePopupScreen(),
                          barrierDismissible: true,
                          barrierColor: Colors.black.withOpacity(0.2),
                          useSafeArea: false,
                        );
                      },
                    )
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              Expanded(
                child: Obx(() {
                  if (controller.affirmations.isEmpty) {
                    return _buildEmptyState();
                  } else {
                    return _buildAffirmationsList();
                  }
                }),
              ),

              SizedBox(height: 20.h),

              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.bottomSheet(
                        AddAffirmationBottomSheet(),
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
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                    ),
                    child: Text(
                      'Add Affirmation',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          addAffirmationPageIcon,
          width: 152.w,
          height: 200.h,
        ),
        SizedBox(height: 40.h),
        Text(
          'Your Own Affirmations',
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Text(
            'Write your own personalized affirmations.\nJust for you, visible only to you.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAffirmationsList() {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: controller.affirmations.length,
      separatorBuilder: (_, __) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final affirmation = controller.affirmations[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Affirmation Text
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 16.h),
                child: Text(
                  affirmation,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),

              // Divider
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Divider(
                  color: Colors.grey[200],
                  thickness: 1,
                ),
              ),

              // Action Row (space for delete, favorite, share)
              Padding(
                padding: EdgeInsets.only(right: 20.w, bottom: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(() => GestureDetector(
                      onTap: () => controller.toggleAffirmationFavorite(index),
                      child: Image.asset(
                        controller.isAffirmationFavorite(affirmation) ? favoriteIcon2 : favoriteIcon1,
                        width: 24.w,
                        height: 24.h,
                      ),
                    )),
                    SizedBox(width: 24.w),
                    GestureDetector(
                      onTap: () => controller.shareAffirmation(affirmation),
                      child: Image.asset(
                        shareIcon,
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),
                    SizedBox(width: 24.w),
                    // In add_affirmations_view.dart, update the delete button
                    GestureDetector(
                      onTap: () => controller.showDeleteConfirmation(index),
                      child: Image.asset(
                        deleteIcon2,
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        );
      },
    );
  }

}