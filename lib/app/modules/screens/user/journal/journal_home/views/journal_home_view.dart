import 'dart:io';

import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/helpers/services/themeServices.dart';
import 'package:affirmations_app/app/modules/screens/user/home/controllers/home_controller.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../controllers/journal_home_controller.dart';

class JournalHomeView extends GetView<JournalHomeController> {
  const JournalHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: const BoxDecoration(
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
                padding: EdgeInsets.only(left: 10.w, right: 20.w, top: 10.h),
                child: CustomAppBar(
                  title: 'Journal',
                  onBackPressed: () => Get.back(),
                  actions: [
                    GestureDetector(
                      onTap: () => controller.openFilter(),
                      child: SvgPicture.asset(
                        datePickerIcon,
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [_buildChartSection(), _buildMoodEntrySection()],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Currently "no data" isn't showing in the center with both axis lines .....
  Widget _buildChartSection() {
    return Container(
      margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => Padding(
              padding: EdgeInsets.only(left: 40.w, right: 20.w, top: 15.h),
              child: Text(
                controller.dateRangeText.value,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          SizedBox(height: 16.h),

          SizedBox(
            height: 200.h,
            child: Obx(() {
              final selectedDate =
                  controller.selectedDate.value != null
                      ? controller.selectedDate.value
                      : DateTime.now();

              print('selected Date ------ > ${selectedDate}');
              // Show loader while loading
              if (controller.loadingStatus.value == LoadingStatus.loading) {
                return Center(
                  child:
                      Platform.isAndroid
                          ? CircularProgressIndicator(
                            strokeWidth: 4.w,
                            color: Colors.black,
                          )
                          : CupertinoActivityIndicator(
                            color: Colors.black,
                            radius: 20.r,
                          ),
                );
              }

              final minDate =
                  controller.chartData.isNotEmpty
                      ? controller.chartData.first.date
                      : DateTime.now().subtract(const Duration(days: 6));
              final maxDate =
                  controller.chartData.isNotEmpty
                      ? controller.chartData.last.date
                      : DateTime.now();

              // Check if selected date has any mood data
              final hasMoodDataForDate = controller.selectedDate.value != null &&
                  controller.chartData.any((item) =>
                  item.date.year == controller.selectedDate.value!.year &&
                      item.date.month == controller.selectedDate.value!.month &&
                      item.date.day == controller.selectedDate.value!.day &&
                      (item.morningMood != null || item.nightMood != null));

              return Stack(
                children: [
                  SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    plotAreaBorderColor: Colors.transparent,
                    primaryXAxis: DateTimeAxis(
                      plotOffset: 8,
                      opposedPosition: false,
                      dateFormat: DateFormat('d'),
                      interval: 1,
                      intervalType: DateTimeIntervalType.days,
                      axisLine: const AxisLine(
                        width: 1.5,
                        color: Color(0xFFC4C4C4),
                      ),
                      majorTickLines: const MajorTickLines(size: 0),
                      majorGridLines: const MajorGridLines(width: 0),
                      labelRotation: 0,
                      // minimum: controller.chartData.first.date.subtract(const Duration(hours: 12)),
                      // maximum: controller.chartData.last.date.add(const Duration(hours: 12)),
                      minimum: minDate,
                      maximum: maxDate,
                      axisLabelFormatter: (AxisLabelRenderDetails details) {
                        final labelDate = DateTime.fromMillisecondsSinceEpoch(
                          details.value.toInt(),
                        );
                        print('labelDate: $labelDate');
                        final isSelected =
                            selectedDate != null &&
                            labelDate.year == selectedDate.year &&
                            labelDate.month == selectedDate.month &&
                            labelDate.day == selectedDate.day;

                        return ChartAxisLabel(
                          DateFormat('d').format(labelDate),
                          GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected ? Colors.black : Colors.grey,
                          ),
                        );
                      },
                    ),
                    primaryYAxis: NumericAxis(
                      plotOffset: 8,
                      minimum: 1,
                      maximum: 5,
                      interval: 1,
                      labelStyle: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                      axisLine: const AxisLine(
                        width: 1.5,
                        color: Color(0xFFC4C4C4),
                      ),
                      majorTickLines: const MajorTickLines(size: 0),
                      majorGridLines: const MajorGridLines(width: 0),
                      axisLabelFormatter: (axisLabelRenderArgs) {
                        final value = axisLabelRenderArgs.value.toInt();
                        String label;
                        switch (value) {
                          case 1:
                            label = 'Tough';
                            break;
                          case 2:
                            label = 'Not Great';
                            break;
                          case 3:
                            label = 'Okay';
                            break;
                          case 4:
                            label = 'Doing Well';
                            break;
                          case 5:
                            label = 'Amazing';
                            break;
                          default:
                            label = '';
                        }
                        return ChartAxisLabel(
                          label,
                          GoogleFonts.inter(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF757575),
                          ),
                        );
                      },
                    ),
                    legend: Legend(isVisible: false),
                    series: hasMoodDataForDate ? <CartesianSeries<ChartData, DateTime>>[
                      if (controller.chartData.isNotEmpty) ...[
                        LineSeries<ChartData, DateTime>(
                          dataSource:
                              controller.chartData
                                  .where(
                                    (data) =>
                                        controller.moodToNumber(
                                          data.morningMood,
                                        ) !=
                                        null,
                                  )
                                  .toList(),
                          xValueMapper: (data, _) => data.date,
                          yValueMapper:
                              (data, _) =>
                                  controller.moodToNumber(data.morningMood),
                          name: 'Morning',
                          color: const Color(0xFFFF92D2),
                          markerSettings: MarkerSettings(
                            isVisible: true,
                            shape: DataMarkerType.circle,
                            color: Color(0xFFFF92D2),
                            // Fill color
                            borderColor: Color(0xFFFF92D2),
                            // Border same as fill for no outline effect
                            borderWidth: 1, // Small border width
                          ),
                        ),
                        LineSeries<ChartData, DateTime>(
                          dataSource:
                              controller.chartData
                                  .where(
                                    (data) =>
                                        controller.moodToNumber(
                                          data.nightMood,
                                        ) !=
                                        null,
                                  )
                                  .toList(),
                          xValueMapper: (data, _) => data.date,
                          yValueMapper:
                              (data, _) =>
                                  controller.moodToNumber(data.nightMood),
                          name: 'Night',
                          color: const Color(0xFFB4A4F9),
                          markerSettings: MarkerSettings(
                            isVisible: true,
                            shape: DataMarkerType.circle,
                            color: Color(0xFFB4A4F9),
                            // Fill color
                            borderColor: Color(0xFFB4A4F9),
                            // Border same as fill for no outline effect
                            borderWidth: 1, // Small border width
                          ),
                        ),
                      ] else ...[
                        // Empty dummy series to render axes
                        LineSeries<ChartData, DateTime>(
                          dataSource: const [],
                          xValueMapper: (_, __) => DateTime.now(),
                          yValueMapper: (_, __) => 0,
                        ),
                      ],
                    ] : <CartesianSeries<ChartData, DateTime>>[],
                    onAxisLabelTapped: (AxisLabelTapArgs args) {
                      if (args.axisName == 'primaryXAxis') {
                        final tappedDate = DateTime.fromMillisecondsSinceEpoch(
                          args.value.toInt(),
                        );
                        // Normalize to midnight
                        final normalizedDate = DateTime(tappedDate.year, tappedDate.month, tappedDate.day);
                        controller.onDateTapped(normalizedDate);
                      }
                    },
                  ),
                  // Show "No Data" when selected date has no mood data
                  if (controller.selectedDate.value != null && !hasMoodDataForDate)
                    Positioned(
                      top: 70.h,
                      left: 38.w,
                      right: 0,
                      child: Center(
                        child: Text(
                          'No Data',
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFA9A9A9),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),

          Padding(
            padding: EdgeInsets.only(left: 20.w, top: 16.h, bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: Color(0xFFFF92D2),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Morning Mood',
                      style: GoogleFonts.inter(fontSize: 10.sp),
                    ),
                  ],
                ),
                SizedBox(width: 16.w),
                Row(
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: Color(0xFFB4A4F9),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Night Mood',
                      style: GoogleFonts.inter(fontSize: 10.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*
  Widget _buildMoodEntrySection() {
    return Obx(() {
      if (controller.selectedDate.value == null) {
        return _buildNewJournalEntry();
      }

      // Normalize selected date to midnight
      final normalizedSelectedDate = DateTime(
        controller.selectedDate.value!.year,
        controller.selectedDate.value!.month,
        controller.selectedDate.value!.day,
      );

      // Check if selected date has any entry in chartData
      final hasEntry = controller.chartData.any(
            (item) =>
        item.date.year == normalizedSelectedDate.year &&
            item.date.month == normalizedSelectedDate.month &&
            item.date.day == normalizedSelectedDate.day,
      );

      print('HasEntry value ------> $hasEntry, selectedDate=$normalizedSelectedDate');

      return hasEntry ? _buildJournalEntryDetails() : _buildNewJournalEntry();
    });
  }

   */

  /*.....
  Widget _buildMoodEntrySection() {
    return Obx(() {

      if (controller.selectedDate.value == null) {
        return _buildNewJournalEntry();
      }

      // Normalize selected date to midnight
      final normalizedSelectedDate = DateTime(
        controller.selectedDate.value!.year,
        controller.selectedDate.value!.month,
        controller.selectedDate.value!.day,
      );

      // Check if selected date has any entry in chartData
      final hasEntry = controller.chartData.any(
            (item) {
          final normalizedItemDate = DateTime(
            item.date.year,
            item.date.month,
            item.date.day,
          );
          return normalizedItemDate == normalizedSelectedDate &&
              (item.morningMood != null ||
                  item.nightMood != null ||
                  item.morningNotes != null ||
                  item.nightNotes != null);
        },
      );

      print('HasEntry value ------> $hasEntry, selectedDate=$normalizedSelectedDate');

      return hasEntry ? _buildJournalEntryDetails() : _buildNewJournalEntry();
    });
  }

   */

  // Widget _buildMoodEntrySection() {
  //   return Obx(() {
  //     if (controller.selectedDate.value == null) {
  //       return SizedBox.shrink(); // Don't show anything if no date is selected
  //     }
  //
  //     // Normalize dates for comparison
  //     final normalizedSelectedDate = DateTime(
  //       controller.selectedDate.value!.year,
  //       controller.selectedDate.value!.month,
  //       controller.selectedDate.value!.day,
  //     );
  //     final normalizedToday = DateTime(
  //       DateTime.now().year,
  //       DateTime.now().month,
  //       DateTime.now().day,
  //     );
  //
  //     // Check if selected date has any entry in chartData
  //     final hasEntry = controller.chartData.any(
  //           (item) {
  //         final normalizedItemDate = DateTime(
  //           item.date.year,
  //           item.date.month,
  //           item.date.day,
  //         );
  //         return normalizedItemDate == normalizedSelectedDate &&
  //             (item.morningMood != null ||
  //                 item.nightMood != null ||
  //                 item.morningNotes != null ||
  //                 item.nightNotes != null);
  //       },
  //     );
  //
  //     // Show entry details if exists for any date
  //     if (hasEntry) {
  //       return _buildJournalEntryDetails();
  //     }
  //     // Show new entry form only if it's today AND no entry exists
  //     else if (normalizedSelectedDate == normalizedToday) {
  //       return _buildNewJournalEntry();
  //     }
  //     // For all other cases (previous dates with no data), show nothing
  //     else {
  //       return SizedBox.shrink();
  //     }
  //   });
  // }

  Widget _buildMoodEntrySection() {
    return Obx(() {
      if (controller.selectedDate.value == null) return SizedBox.shrink();

      final isToday = controller.selectedDate.value!.year == DateTime.now().year &&
          controller.selectedDate.value!.month == DateTime.now().month &&
          controller.selectedDate.value!.day == DateTime.now().day;

      final hasEntry = controller.chartData.any((item) =>
      item.date.year == controller.selectedDate.value!.year &&
          item.date.month == controller.selectedDate.value!.month &&
          item.date.day == controller.selectedDate.value!.day &&
          (item.morningMood != null || item.nightMood != null));

      if (hasEntry) return _buildJournalEntryDetails();
      if (isToday) return _buildNewJournalEntry();
      return SizedBox.shrink();
    });
  }

  Widget _buildNewJournalEntry() {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'How do you feel right now?',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Column(
            children:
                controller.moods.map((mood) => _buildMoodOption(mood)).toList(),
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Why do you feel this way?',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '(${controller.notesLength.value}/100)',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Color(0xFFA9A9A9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: controller.notesController,
            onTap: () {
              if (Get.find<HomeController>().isGuestUser.value) {
                Get.find<HomeController>().showGuestPopup();
              }
            },
            onChanged: (value) {
              if (Get.find<HomeController>().isGuestUser.value) {
                Get.find<HomeController>().showGuestPopup();
                controller.notesController.clear(); // Clear any input
              } else {
                controller.updateNotes(value);
              }
            },
            maxLines: 4,
            maxLength: 100,
            decoration: InputDecoration(
              hintText: 'Add notes here...',
              hintStyle: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xffA9A9A9),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.all(16.r),
              counterText: '', // hides default counter
            ),
          ),
          SizedBox(height: 30.h),
          Container(
            margin: EdgeInsets.only(bottom: 20.h),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.submitJournalEntry(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              child: Text(
                'Submit',
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
    );
  }

  Widget _buildMoodOption(String mood) {
    return Obx(() {
      bool isSelected = controller.selectedMood.value == mood;
      return GestureDetector(
        onTap: () => controller.selectMood(mood),
        child: Container(
          margin: EdgeInsets.only(bottom: 15.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(color: Colors.white),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                mood,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              Image.asset(
                isSelected ? selectedIcon : unselectedIcon,
                width: 14.w,
                height: 14.h,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildJournalEntryDetails() {
    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your mood was',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(22.r),
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMoodIndicator('Morning', controller.morningMood.value),
                // SizedBox(width: .w),
                _buildMoodIndicator('Night', controller.nightMood.value),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Notes',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h),

          Container(
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(22.r),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Morning Writing',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 16.h),

                if (controller.morningNotes.value.isNotEmpty) ...[
                  Text(
                    controller.morningNotes.value,
                    style: GoogleFonts.inter(fontSize: 14.sp),
                  ),
                ] else ...[
                  Text(
                    '-',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      color: Colors.black,
                    ),
                  ),
                ],

                SizedBox(height: 10.h),

                Divider(
                  color: Colors.black.withOpacity(0.4),
                  thickness: 0.5,
                  height: 20.h,
                ),

                SizedBox(height: 10.h),

                Text(
                  'Night Writing',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 16.h),

                if (controller.nightNotes.value.isNotEmpty) ...[
                  Text(
                    controller.nightNotes.value,
                    style: GoogleFonts.inter(fontSize: 14.sp),
                  ),
                ] else ...[
                  Text(
                    '-',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      color: Colors.black,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*
  Widget _buildMoodIndicator(String time, String? mood) {
    final emoji = mood != null ? _getMoodEmoji(mood) : '';
    return Text(
      mood != null ? '$emoji $mood' : '$emoji Not Recorded',
      style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w500),
      overflow: TextOverflow.ellipsis,
    );
  }

   */

  Widget _buildMoodIndicator(String time, String? mood) {
    final emojiImage = mood != null ? _getMoodImage(mood) : null;
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (emojiImage != null)
              Padding(
                padding: EdgeInsets.only(right: 4.w),
                child: Image.asset(
                  emojiImage,
                  width: 20.w,
                  height: 20.h,
                ),
              ),
            Flexible(
              child: Text(
                mood != null ? mood : 'Not Recorded',
                style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500
                ),
                overflow: TextOverflow.ellipsis,
                // maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMoodImage(String mood) {
    switch (mood) {
      case 'Feeling Amazing':
        return feelingAmazing;

      case 'Doing Well':
        return doingWell;
      case 'Feeling Okay':
        return feelingOkay;
      case 'Not Great':
        return notGreat;
      case 'Having a Tough Time':
        return toughTime;
      default:
        return "";
    }
  }

  /*
  String _getMoodEmoji(String mood) {
    switch (mood) {
      case 'Feeling Amazing':
        return '🌟';
      case 'Doing Well':
        return '👍';
      case 'Feeling Okay':
        return '😐';
      case 'Not Great':
        return '👎';
      case 'Having a Tough Time':
        return '😞';
      default:
        return "";
    }
  }

   */

}
