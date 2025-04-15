import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/modules/screens/common/app_settings/FAQ/controllers/faq_controller.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FaqView extends GetView<FaqController> {
  const FaqView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage2),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
            child: Column(
              children: [

                // App Bar
                CustomAppBar(title: "FAQs"),

                // FAQ List
                Expanded(
                  child: Obx(() => NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification.metrics.pixels ==
                          scrollNotification.metrics.maxScrollExtent &&
                          !controller.isLoading.value &&
                          controller.hasMore.value) {
                        controller.loadMoreFaqs();
                      }
                      return false;
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 20.h),
                      itemCount: controller.displayedFaqs.length + (controller.hasMore.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= controller.displayedFaqs.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        return _buildFaqItem(controller.displayedFaqs[index], index);
                      },
                    ),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFaqItem(FaqItem faq, int index) {
    return Obx(() {
      final isExpanded = controller.expandedIndex.value == index;
      return Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: Column(
          children: [

            // Question Container
            Container(
              decoration: BoxDecoration(
                color: isExpanded ? Colors.black : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isExpanded ? 20.r : 20.r),
                  topRight: Radius.circular(isExpanded ? 20.r : 20.r),
                  bottomLeft: Radius.circular(isExpanded ? 0 : 20.r),
                  bottomRight: Radius.circular(isExpanded ? 0 : 20.r),
                ),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                title: Text(
                  faq.question,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isExpanded ? Colors.white : Colors.black,
                  ),
                ),
                trailing: SizedBox(
                  child: isExpanded
                      ? SvgPicture.asset(upwardArrow, height: 20.h, width: 20.w) // Your up arrow SVG
                      : SvgPicture.asset(downwardArrow, height: 20.h, width: 20.w), // Your down arrow SVG
                ),
                onTap: () => controller.toggleExpansion(index),
              ),
            ),

            // Answer Container
            if (isExpanded)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                child: Text(
                  faq.answer,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    height: 1.4,
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}