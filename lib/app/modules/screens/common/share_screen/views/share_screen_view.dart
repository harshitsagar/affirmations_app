import 'dart:ui';
import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/share_screen_controller.dart';

class ShareScreenView extends GetView<ShareScreenController> {

  final String? affirmation;
  final Function(bool)? onShared;

  const ShareScreenView({super.key, this.affirmation, this.onShared});

  @override
  Widget build(BuildContext context) {

    Get.put(ShareScreenController());

    if (affirmation != null) {
      controller.initializeContent(affirmation!, onSharedCallback: onShared);
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Grey bar at top
            Padding(
              padding: EdgeInsets.only(top: 14.h),
              child: Container(
                width: 50.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),

            // Row: Share with Friends + Icon
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Share with Friends",
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.copyMessageToClipboard,
                    child: Image.asset(
                      copyIcon,
                      width: 15.w,
                      height: 15.h,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            Divider(color: Colors.grey[300], thickness: 1.h),

            // Row with Message and WhatsApp
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 60.w, top: 10.h, bottom: 30.h),
                  child: GestureDetector(
                    onTap: controller.shareToMessage,
                    child: Column(
                      children: [
                        Image.asset(
                          messageIcon,
                          width: 30.w,
                          height: 30.h,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Message",
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 30.h),
                  child: GestureDetector(
                    onTap: controller.shareToWhatsapp,
                    child: Column(
                      children: [
                        Image.asset(
                          whatsappIcon,
                          width: 30.w,
                          height: 30.h,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Whatsapp",
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}