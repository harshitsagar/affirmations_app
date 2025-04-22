import 'package:affirmations_app/app/modules/screens/user/streak/streak_screen/controllers/streak_screen_controller.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:affirmations_app/app/data/components/images_path.dart';

class StreakScreenView extends GetView<StreakScreenController> {
  const StreakScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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

                // Custom AppBar
                CustomAppBar(title: "Streak"),

                SizedBox(height: 20.h),

                // Main content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        // Streak status container
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h, bottom: 16.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Column(
                            children: [
                              // Days and status row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Obx(() => Text(
                                            '${controller.currentStreak.value} days',
                                            style: GoogleFonts.inter(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )),

                                          SizedBox(width: 8.w),

                                          Obx(() {
                                            switch (controller.currentStreakState.value) {
                                              case 'freeze':
                                                return SvgPicture.asset(
                                                  freezeIcon,
                                                  height: 16.h,
                                                  width: 16.w,
                                                );
                                              case 'restore':
                                                return SvgPicture.asset(
                                                  restoreIcon,
                                                  height: 16.h,
                                                  width: 16.w,
                                                );
                                              default:
                                                return SizedBox.shrink();
                                            }
                                          }),
                                        ],
                                      ),
                                      SizedBox(height: 4.h),
                                      Obx(() => Text(
                                        controller.streakStatus.value,
                                        style: GoogleFonts.inter(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xffA9A9A9),
                                        ),
                                      )),
                                    ],
                                  ),

                                  // Circular progress with fire icon
                                  Obx(() => Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        width: 65.w,
                                        height: 58.h,
                                        child: CircularProgressIndicator(
                                          value: controller.currentStreak.value / 30,
                                          strokeWidth: 8.w,
                                          backgroundColor: Colors.grey[200],
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                                        ),
                                      ),
                                      Positioned(
                                        right: 17.w,
                                        top: 14.h,
                                        child: Image.asset(
                                          fireIcon,
                                          width: 28.w,
                                          height: 28.h,
                                        ),
                                      ),
                                    ],
                                  )),
                                ],
                              ),

                              SizedBox(height: 16.h),

                              // Action buttons row (Freeze/Restore)
                              Obx(() {

                                final canFreeze = controller.freezeStreaksAvailable.value > 0;
                                final canRestore = controller.restoreStreaksAvailable.value > 0;

                                if (canFreeze || canRestore) {
                                  return Row(
                                    children: [
                                      if (canFreeze)
                                        Expanded(
                                          child: _buildActionButton(
                                            icon: freezeIcon,
                                            label: 'Freeze',
                                            count: controller.freezeStreaksAvailable.value,
                                            color: Color(0xFF3B82F6),
                                            check: canFreeze,
                                            onTap: () => controller.showFreezeStreakOption(),
                                          ),
                                        ),
                                      if (canFreeze && canRestore) SizedBox(width: 15.w),
                                      if (canRestore)
                                        Expanded(
                                          child: _buildActionButton(
                                            icon: restoreIcon,
                                            label: 'Restore',
                                            count: controller.restoreStreaksAvailable.value,
                                            color: Color(0xFF84CC16),
                                            check: canRestore,
                                            onTap: () => controller.showRestoreStreakOption(),
                                          ),
                                        ),
                                    ],
                                  );
                                }
                                return SizedBox.shrink();
                              }),

                              // Row(
                              //   children: [
                              //
                              //     // // Freeze button
                              //     Expanded(
                              //       child: _buildActionButton(
                              //         icon: freezeIcon, // Replace with your freeze icon
                              //         label: 'Freeze',
                              //         count: controller.freezeStreaksAvailable.value,
                              //         color: Color(0xFF3B82F6),
                              //       ),
                              //     ),
                              //
                              //     // // Restore button
                              //     Expanded(
                              //       child: _buildActionButton(
                              //         icon: restoreIcon, // Replace with your restore icon
                              //         label: 'Restore',
                              //         count: controller.restoreStreaksAvailable.value,
                              //         color: Color(0xFF84CC16),
                              //       ),
                              //     ),
                              //
                              //   ],
                              // ),

                              // SizedBox(height: 20.h),
                              //
                              // // Freeze button
                              // _buildActionButton(
                              //   icon: freezeIcon, // Replace with your freeze icon
                              //   label: 'Freeze',
                              //   count: controller.freezeStreaksAvailable.value,
                              //   color: Color(0xFF3B82F6),
                              // ),
                              //
                              // SizedBox(height: 20.h),
                              //
                              // // Restore button
                              // _buildActionButton(
                              //   icon: restoreIcon, // Replace with your restore icon
                              //   label: 'Restore',
                              //   count: controller.restoreStreaksAvailable.value,
                              //   color: Color(0xFF84CC16),
                              // ),

                            ],
                          ),
                        ),

                        SizedBox(height: 30.h),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Streak Challenge',
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),

                        SizedBox(height: 10.h),

                        // Streak Challenge section
                        Stack(
                          children: [

                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  // Monthly Challenge progress
                                  Container(
                                    padding: EdgeInsets.only(left: 16.w, right: 20.w, top: 16.h, bottom: 20.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Monthly Challenge',
                                          style: GoogleFonts.inter(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 18.h),
                                        Obx(() => LinearProgressIndicator(
                                          value: controller.completedDays.value / controller.monthlyChallengeDays.value,
                                          backgroundColor: Colors.grey[200],
                                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF92D2)),
                                          minHeight: 8.h,
                                          borderRadius: BorderRadius.circular(5.r),
                                        )),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            Positioned(
                              top: 45.h,
                              left: 65.w,
                              child: Container(
                                width: 24.w,
                                height: 24.h,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFF92D2),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '7',
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              top: 45.h,
                              left: 130.w,
                              child: Container(
                                width: 24.w,
                                height: 24.h,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFF92D2),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '14',
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              top: 45.h,
                              right: 12.w,
                              child: Container(
                                width: 24.w,
                                height: 24.h,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFF92D2),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '30',
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),

                        SizedBox(height: 20.h),

                        // Calendar section
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Obx(() => TableCalendar(
                            firstDay: DateTime(2025, 1, 1),
                            lastDay: DateTime(2025, 12, 31),
                            focusedDay: controller.focusedDay.value,
                            calendarFormat: controller.calendarFormat.value,
                            selectedDayPredicate: (day) => isSameDay(day, controller.selectedDate.value),
                            onDaySelected: controller.onDaySelected,
                            onFormatChanged: (format) => controller.calendarFormat.value = format,
                            onPageChanged: (focusedDay) => controller.focusedDay.value = focusedDay,
                            calendarStyle: CalendarStyle(
                              defaultTextStyle: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              selectedTextStyle: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              todayTextStyle: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              selectedDecoration: BoxDecoration(
                                color: _getSelectedDateColor(controller.selectedDate.value),
                                shape: BoxShape.circle,
                              ),
                              todayDecoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black),
                              ),
                              markerDecoration: BoxDecoration(
                                color: _getMarkerColor(controller.selectedDate.value),
                                shape: BoxShape.circle,
                              ),
                              markersAlignment: Alignment.bottomCenter,
                              markerSize: 6,
                              outsideDaysVisible: true,

                              weekendTextStyle: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              outsideTextStyle: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffA9A9A9),
                              ),
                            ),
                            headerStyle: HeaderStyle(
                              formatButtonVisible: false,
                              titleCentered: true,
                              titleTextStyle: GoogleFonts.inter(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              leftChevronIcon: Icon(Icons.chevron_left, size: 24.w, color: Colors.black),
                              rightChevronIcon: Icon(Icons.chevron_right, size: 24.w, color: Colors.black),
                              leftChevronPadding: EdgeInsets.only(right: 16.w),
                              rightChevronPadding: EdgeInsets.only(left: 16.w),
                            ),
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              weekendStyle: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            // rowHeight: 40.h,
                            daysOfWeekHeight: 20.h,

                            calendarBuilders: CalendarBuilders(
                              markerBuilder: (context, date, events) {
                                if (controller.completedDates.contains(date)) {
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.pink,
                                      shape: BoxShape.circle,
                                    ),
                                    width: 6,
                                    height: 6,
                                  );
                                } else if (controller.freezedDates.contains(date)) {
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                    width: 6,
                                    height: 6,
                                  );
                                } else if (controller.restoredDates.contains(date)) {
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                    width: 6,
                                    height: 6,
                                  );
                                } else if (controller.brokenDates.contains(date)) {
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.brown,
                                      shape: BoxShape.circle,
                                    ),
                                    width: 6,
                                    height: 6,
                                  );
                                }
                                return SizedBox.shrink();
                              },
                            ),
                          )),
                        ),

                        SizedBox(height: 20.h),

                      ],
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

  Widget _buildActionButton({
    required String icon,
    required String label,
    required int count,
    required Color color,
    required bool check,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 44.h,
            width: double.infinity,
            padding: check
                    ? EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w)
                    : EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white, // match screenshot background
              borderRadius: BorderRadius.circular(16.r), // rounded pill look
              border: Border.all(color: Colors.grey.shade300, width: 1.w),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  icon,
                  height: check ? 12.h : 16.h,
                  width: check ? 12.w : 16.w,
                ),
                SizedBox(width: 8.w),
                Text(
                  '$label Streak',
                  style: GoogleFonts.inter(
                    fontSize: check ? 12.sp : 14.sp,
                    fontWeight: FontWeight.w500,
                    color: color,
                  ),
                ),
              ],
            ),
          ),

          // Badge
          if (count > 0)
            Positioned(
              top: -6.h,
              right: -6.w,
              child: Container(
                height: 20.h,
                width: 20.w,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$count',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getSelectedDateColor(DateTime date) {
    // Only return selection color if it's the currently selected date
    if (isSameDay(date, controller.selectedDate.value)) {
      if (controller.freezedDates.contains(date)) return Colors.blue;
      if (controller.restoredDates.contains(date)) return Colors.green;
      if (controller.completedDates.contains(date)) return Colors.pink;
      return Colors.black; // Default selection color
    }
    return Colors.transparent; // Not selected
  }

  Color _getMarkerColor(DateTime date) {
    if (controller.completedDates.contains(date)) return Colors.pink;
    if (controller.freezedDates.contains(date)) return Colors.blue;
    if (controller.restoredDates.contains(date)) return Colors.green;
    if (controller.brokenDates.contains(date)) return Colors.brown;
    return Colors.transparent;
  }

}