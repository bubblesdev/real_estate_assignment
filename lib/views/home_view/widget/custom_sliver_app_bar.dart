import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/color_palletes.dart';
import '../home_screen.dart';
import 'package:intl/intl.dart';

class CustomSliverAppBar extends StatefulWidget {
  const CustomSliverAppBar({
    super.key,
    required Animation<double> locationBoxAnimation,
    required Animation<double> avatarScaleAnimation,
  })  : _locationBoxAnimation = locationBoxAnimation,
        _avatarScaleAnimation = avatarScaleAnimation;

  final Animation<double> _locationBoxAnimation;
  final Animation<double> _avatarScaleAnimation;

  @override
  State<CustomSliverAppBar> createState() => CustomSliverAppBarState();
}

class CustomSliverAppBarState extends State<CustomSliverAppBar>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final numberFormat = NumberFormat('#,###', 'en_US');
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 0,
      title: Container(
        width: widget._locationBoxAnimation.value,
        padding: EdgeInsets.symmetric(
          vertical: 1.5.h,
          horizontal: 4.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppcolorPallettes.kwhite,
          boxShadow: [
            BoxShadow(
              color: AppcolorPallettes.kdarkGrey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 8,
              blurStyle: BlurStyle.inner,
            )
          ],
        ),
        child: FadeTransition(
          opacity: widget._locationBoxAnimation,
          child: Text(
            "Saint Petersburg",
            style: TextStyle(
              color: AppcolorPallettes.kdarkGrey,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      actions: [
        ScaleTransition(
          scale: widget._avatarScaleAnimation,
          child: const CircleAvatar(
            backgroundColor: AppcolorPallettes.kOrange,
          ),
        ),
      ],
      centerTitle: false,
      toolbarHeight: 10.h,
      collapsedHeight: 18.h,
      pinned: true,
      expandedHeight: 48.h,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.none,
        titlePadding: EdgeInsets.zero,
        expandedTitleScale: 1,
        title: const Padding(
          padding: EdgeInsets.only(bottom: 12.0),
        ),
        background: widget._locationBoxAnimation.isCompleted
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Gap(16.h),
                  Text(
                    "Hi, Marina",
                    style: TextStyle(
                      color: AppcolorPallettes.kdarkGrey,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ).animate().fade(duration: 1000.ms),
                  Gap(1.h),
                  Text(
                    "Let's select your\nperfect place",
                    style: TextStyle(
                      color: AppcolorPallettes.kblack,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ).animate().fade(duration: 2000.ms),
                  Gap(2.h),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: ClipPath(
                            clipper: CircleClipper(),
                            child: Container(
                              padding: EdgeInsets.only(top: 3.h),
                              color: AppcolorPallettes.kOrange,
                              child: Column(
                                children: [
                                  Text(
                                    "BUY",
                                    style: TextStyle(
                                      color: AppcolorPallettes.kwhite
                                          .withOpacity(0.8),
                                      fontSize: 11.9.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Expanded(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(
                                          top: 3.5.h,
                                          child: countingNumbers(
                                            numberFormat,
                                            1034,
                                            color: AppcolorPallettes.kwhite
                                                .withOpacity(0.95),
                                          ),
                                        ),
                                        Positioned(
                                          top: 8.5.h,
                                          child: Text(
                                            "offers",
                                            style: TextStyle(
                                              color: AppcolorPallettes.kwhite
                                                  .withOpacity(0.8),
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).animate().scale(
                                duration: 1000.ms,
                              ),
                        ),
                        Gap(3.w),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(vertical: 1.h),
                            padding: EdgeInsets.all(1.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "RENT",
                                  style: TextStyle(
                                    color: AppcolorPallettes.kdarkGrey
                                        .withOpacity(0.6),
                                    fontSize: 11.9.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Expanded(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Positioned(
                                        top: 3.5.h,
                                        child:
                                            countingNumbers(numberFormat, 2212),
                                      ),
                                      Positioned(
                                        top: 8.5.h,
                                        child: Text(
                                          "offers",
                                          style: TextStyle(
                                            color: AppcolorPallettes.kdarkGrey,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ).animate().scale(
                                duration: 1000.ms,
                              ),
                        ),
                      ],
                    ),
                  ),

                ],
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  TweenAnimationBuilder<double> countingNumbers(
      NumberFormat numberFormat, int value,
      {Color? color}) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 0,
        end: value.toDouble(),
      ),
      duration: const Duration(
        milliseconds: 1500,
      ),
      builder: (context, value, child) {
        String formattedValue = numberFormat.format(value.toInt());
        formattedValue = formattedValue.replaceAll(',', ' ');
        return Text(
          formattedValue,
          style: TextStyle(
            color: color ?? AppcolorPallettes.kdarkGrey,
            fontSize: 25.sp,
            fontWeight: FontWeight.w900,
          ),
        );
      },
    );
  }
}
