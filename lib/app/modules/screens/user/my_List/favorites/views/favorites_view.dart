import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:affirmations_app/app/data/components/images_path.dart';
import '../controllers/favorites_controller.dart';

class FavoritesView extends GetView<FavoritesController> {
  const FavoritesView({super.key});

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
                  title: 'Favorites',
                  onBackPressed: () => Get.back(),
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: Obx(
                        () => controller.favoriteAffirmations.isEmpty
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
                      itemCount: controller.favoriteAffirmations.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final affirmation = controller.favoriteAffirmations[index];
                        return _buildAffirmationCard(affirmation, controller);
                      },
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

  Widget _buildAffirmationCard(String affirmation, FavoritesController controller) {
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
              affirmation,
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
                  onTap: () => controller.removeFavorite(affirmation),
                  child: Image.asset(
                    favoriteIcon2,
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
                SizedBox(width: 24.w),
                GestureDetector(
                  onTap: () => controller.shareAffirmation(affirmation),
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