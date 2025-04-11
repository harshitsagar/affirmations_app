import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPopupDialog extends StatelessWidget {
  final String title;
  final String description;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final Color? primaryButtonColor;
  final Color? secondaryButtonColor;
  final Color? primaryTextColor;
  final Color? secondaryTextColor;
  final bool showDivider;
  final double? descriptionWidth ;
  final bool singleButtonMode;

  const CustomPopupDialog({
    super.key,
    required this.title,
    required this.description,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.primaryButtonColor,
    this.secondaryButtonColor,
    this.primaryTextColor,
    this.secondaryTextColor,
    this.showDivider = true,
    this.descriptionWidth ,
    this.singleButtonMode = false,
  }) : assert(
  !singleButtonMode || (singleButtonMode && primaryButtonText != null),
  'In single button mode, primaryButtonText must be provided',
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85.w,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10.r,
                spreadRadius: 2.r,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),                    child: Text(
                      title,
                      style: GoogleFonts.inter(
                        color: const Color(0xff12121D),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: descriptionWidth ?? double.infinity,
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Color(0xff12121D),
                        height: 1.2.h,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              _buildButtonSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonSection() {
    if (singleButtonMode) {
      return _buildSingleButton();
    }
    return _buildDualButtons();
  }

  Widget _buildSingleButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r),
        ),
      ),
      child: TextButton(
        onPressed: onPrimaryPressed ?? () => Get.back(),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12.r),
              bottomLeft: Radius.circular(12.r),
            ),
          ),
          padding: EdgeInsets.all(20.r),
          backgroundColor: primaryButtonColor ?? Colors.black,
        ),
        child: Text(
          primaryButtonText!,
          style: GoogleFonts.openSans(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: primaryTextColor ?? Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildDualButtons() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: onPrimaryPressed ?? () => Get.back(),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.zero,
                    bottomLeft: Radius.circular(12.r),
                  ),
                ),
                padding: EdgeInsets.all(20.r),
                backgroundColor: primaryButtonColor ?? Colors.black,
              ),
              child: Text(
                primaryButtonText ?? 'Ask Not to Track',
                style: GoogleFonts.openSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: primaryTextColor ?? Colors.white,
                ),
              ),
            ),
          ),
          if (showDivider)
            Container(
              width: 1.5.w,
              height: 44.h,
              color: Colors.grey.shade300,
            ),
          Expanded(
            child: TextButton(
              onPressed: onSecondaryPressed ?? () => Get.back(),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.circular(12.r),
                  ),
                  side: BorderSide(
                    color: Colors.grey,
                    width: 0.5.w,
                  ),
                ),
                padding: const EdgeInsets.all(20),
                backgroundColor: secondaryButtonColor,
              ),
              child: Text(
                secondaryButtonText ?? 'Allow',
                style: GoogleFonts.openSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: secondaryTextColor ?? Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}