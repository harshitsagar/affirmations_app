import 'dart:io';
import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/helpers/constants/app_colors.dart';
import 'package:affirmations_app/app/helpers/services/themeServices.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoPage extends StatelessWidget {
  final String title;
  final String? content;
  final LoadingStatus loadingStatus;

  const InfoPage({
    super.key,
    required this.title,
    this.content,
    this.loadingStatus = LoadingStatus.loading,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(bgImage),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        decoration: ThemeService.getBackgroundDecoration(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                CustomAppBar(title: title),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: loadingStatus == LoadingStatus.loading
                          ? Center(
                        child: Platform.isAndroid
                            ? CircularProgressIndicator(
                          color: AppColors.white,
                        )
                            : CupertinoActivityIndicator(
                          color: AppColors.white,
                          radius: 15.r,
                        ),
                      )
                          : Text(
                        content ??
                            "Lorem ipsum dolor sit amet consectetur. Viverra vitae facilisis proin malesuada faucibus libero. Pellentesque sagittis dis non tellus hac imperdiet posuere vulputate. Ultricies pretium fames arcu accumsan turpis facilisi diam pellentesque sagittis.\n\nSit sit egestas sodales in non amet risus. Vitae dolor dictum mauris aliquet. Semper odio rhoncus nec mus. Interdum mauris faucibus eu luctus pretium lectus. Integer sed id mi elit quis lacus eget. Ac enim nibh pretium in imperdiet arcu quis dapibus. Mauris quis leo sit vitae blandit volutpat tempor. Porttitor vulputate enim sit hendrerit vitae vel vitae.\n\nEget nisi leo elementum turpis in malesuada ultricies diam cursus. In nibh sed mauris amet vel. Sagittis fermentum ut viverra id sit semper facilisi ullamcorper. Porttitor ultricies interdum egestas risus.\n\nSit sit egestas sodales in non amet risus. Vitae dolor dictum mauris aliquet. Semper odio rhoncus nec mus. Interdum mauris faucibus eu luctus pretium lectus. Integer sed id mi elit quis lacus eget. Ac enim nibh pretium in imperdiet arcu quis dapibus. Mauris quis leo sit vitae blandit volutpat tempor. Porttitor vulputate enim sit hendrerit vitae vel vitae.",
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
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
}

// Usage Example with API:
// Get.to(() => InfoPage(
//       title: "Terms & Conditions",
//       loadingStatus: controller.loadingStatus,
//       content: controller.termsContent,
//     ));

// In your controller:
// class InfoController extends GetxController {
//   var loadingStatus = LoadingStatus.loading.obs;
//   String? termsContent;
//   String? privacyContent;
//
//   Future<void> fetchTerms() async {
//     try {
//       loadingStatus(LoadingStatus.loading);
//       final response = await yourApiCall();
//       termsContent = response['content'];
//       loadingStatus(LoadingStatus.completed);
//     } catch (e) {
//       loadingStatus(LoadingStatus.error);
//     }
//   }
// }