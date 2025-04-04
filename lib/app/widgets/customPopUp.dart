import 'package:flutter/material.dart';
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
  final double? descriptionWidth;
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
    this.descriptionWidth,
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
          width: MediaQuery.of(context).size.width * 0.89,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        color: const Color(0xff12121D),
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: descriptionWidth ?? double.infinity,
                      child: Text(
                        description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff12121D),
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: TextButton(
        onPressed: onPrimaryPressed ?? () => Get.back(),
        style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          padding: const EdgeInsets.all(20),
          backgroundColor: primaryButtonColor ?? Colors.black,
        ),
        child: Text(
          primaryButtonText!,
          style: GoogleFonts.openSans(
            fontSize: 16,
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
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: onPrimaryPressed ?? () => Get.back(),
              style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.zero,
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                backgroundColor: primaryButtonColor ?? Colors.black,
              ),
              child: Text(
                primaryButtonText ?? 'Ask Not to Track',
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryTextColor ?? Colors.white,
                ),
              ),
            ),
          ),
          if (showDivider)
            Container(
              width: 1.5,
              height: 44,
              color: Colors.grey.shade300,
            ),
          Expanded(
            child: TextButton(
              onPressed: onSecondaryPressed ?? () => Get.back(),
              style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.circular(12),
                  ),
                  side: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
                padding: const EdgeInsets.all(20),
                backgroundColor: secondaryButtonColor,
              ),
              child: Text(
                secondaryButtonText ?? 'Allow',
                style: GoogleFonts.openSans(
                  fontSize: 16,
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