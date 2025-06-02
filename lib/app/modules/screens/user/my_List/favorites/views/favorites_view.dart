import 'dart:io';

import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/helpers/services/themeServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:affirmations_app/app/data/components/images_path.dart';
import '../../../../../../data/models/favList_model.dart';
import '../../../../../../helpers/constants/app_colors.dart';
import '../controllers/favorites_controller.dart';

class FavoritesView extends GetView<FavoritesController> {
  const FavoritesView({super.key});

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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              children: [
                CustomAppBar(
                  title: 'Favorites',
                  onBackPressed: () => Get.back(),
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: Obx(() {
                    if (controller.loadingStatus.value == LoadingStatus.loading) {
                      return Center(
                        child: Platform.isAndroid
                            ? CircularProgressIndicator(
                          strokeWidth: 4.w,
                          color: AppColors.black,
                        )
                            : CupertinoActivityIndicator(
                          color: AppColors.black,
                          radius: 20.r,
                        ),
                      );
                    }

                    return controller.favoriteList.isEmpty
                        ? Center(
                      child: Text(
                        'No favorites yet',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    )
                        : ListView.separated(
                      itemCount: controller.favoriteList.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final item = controller.favoriteList[index];
                        return _buildAffirmationCard(item, controller);
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAffirmationCard(Data affirmation, FavoritesController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 16.h),
            child: Text(
              affirmation.name ?? 'No name', // Display the affirmation text from model
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
            child: Divider(
              color: Colors.grey[200],
              thickness: 1,
              height: 20.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.w, bottom: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => controller.removeFavorite(affirmation.sId ?? ''),
                  child: Image.asset(
                    affirmation.isLiked == true ? favoriteIcon2 : favoriteIcon1,
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
                SizedBox(width: 24.w),
                GestureDetector(
                  onTap: () => controller.shareAffirmation(affirmation.name ?? ''),
                  child: Image.asset(
                    shareIcon,
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
  }

}
