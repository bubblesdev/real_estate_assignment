import 'package:flutter/material.dart';
import 'package:real_estate_ui/constants/color_palletes.dart';
import 'package:real_estate_ui/views/home_view/models/bottom_tab_items.dart';
import 'package:rive/rive.dart' hide LinearGradient;
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class CustomTabBar extends StatefulWidget {
  int selectedTab;
  CustomTabBar(
      {super.key, required this.onTabChange, required this.selectedTab});
  final Function(int tabIndex) onTabChange;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  final List<BottomTabItem> _icons = BottomTabItem.tabItemsList;

  void _onRiveIconInit(Artboard artboard, index) {
    final controller = StateMachineController.fromArtboard(
        artboard, _icons[index].stateMachine);
    artboard.addController(controller!);
    _icons[index].status = controller.findInput<bool>("active") as SMIBool;
  }

  void onTabPress(int index) {
    if (widget.selectedTab != index) {
      setState(() {
        widget.selectedTab = index;
      });
      widget.onTabChange(index);
      _icons[index].status!.change(true);
      Future.delayed(const Duration(seconds: 1), () {
        _icons[index].status!.change(false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.fromLTRB(15.w, 0, 15.w, 2.h),
        padding: EdgeInsets.all(1.w),
        constraints: const BoxConstraints(maxWidth: 768),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(34),
          gradient: LinearGradient(colors: [
            Colors.white.withOpacity(0.5),
            Colors.white.withOpacity(0)
          ]),
        ),
        child: Container(
          height: 50.sp,
          width: 50.sp,
          clipBehavior: Clip.hardEdge,
          padding: EdgeInsets.all(1.w),
          decoration: BoxDecoration(
            color: AppcolorPallettes.kblack,
            borderRadius: BorderRadius.circular(34),
            boxShadow: [
              BoxShadow(
                color: AppcolorPallettes.kblack.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_icons.length, (index) {
              BottomTabItem icon = _icons[index];
              bool isSelected = widget.selectedTab == index;
              return Expanded(
                key: icon.id,
                child: GestureDetector(
                  onTap: () {
                    onTabPress(index);
                  },
                  child: AnimatedOpacity(
                    opacity: isSelected ? 1 : 0.5,
                    duration: const Duration(milliseconds: 200),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          width: isSelected ? 60 : 40,
                          height: isSelected ? 60 : 40,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppcolorPallettes.kOrange
                                : AppcolorPallettes.kdarkGrey.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(
                          height: isSelected ? 36 : 24,
                          width: isSelected ? 36 : 24,
                          child: RiveAnimation.asset(
                            "assets/rive/icons.riv",
                            stateMachines: [icon.stateMachine],
                            artboard: icon.artboard,
                            onInit: (artboard) {
                              _onRiveIconInit(artboard, index);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
