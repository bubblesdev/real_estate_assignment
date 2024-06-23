import 'package:flutter/material.dart';
import 'package:real_estate_ui/constants/color_palletes.dart';
import 'package:shadcn_ui/shadcn_ui.dart' as shadcn;
import 'package:sizer/sizer.dart';

class PopoverPage extends StatefulWidget {
  final Widget child;
  final ValueNotifier<int> selectedIndexNotifier;
  const PopoverPage(
      {super.key, required this.child, required this.selectedIndexNotifier});

  @override
  State<PopoverPage> createState() => PopoverPageState();
}

class PopoverPageState extends State<PopoverPage> {
  final popoverController = shadcn.ShadPopoverController();
  final List<({IconData icon, String initialValue})> layer = [
    (icon: Icons.verified_user_outlined, initialValue: 'Cosy areas'),
    (icon: Icons.wallet, initialValue: 'Price'),
    (icon: Icons.cabin, initialValue: 'Infrastructure'),
    (icon: Icons.layers_outlined, initialValue: 'Without any layer'),
  ];

  @override
  void dispose() {
    popoverController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return shadcn.ShadPopover(
      controller: popoverController,
      decoration: shadcn.ShadDecoration(
        color: const Color(0xFFfbf5eb),
        border: shadcn.ShadBorder(
          radius: BorderRadius.circular(20),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 18, 10, 15),
      popover: (context) => Wrap(
        spacing: 20,
        direction: Axis.vertical,
        children: [
          ...layer
              .asMap()
              .map((i, e) => MapEntry(
                    i,
                    GestureDetector(
                      onTap: () {
                        widget.selectedIndexNotifier.value = i;
                        popoverController.toggle();
                      },
                      child: Opacity(
                        opacity: 0.9,
                        child: Wrap(
                          direction: Axis.horizontal,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8,
                          children: [
                            Icon(
                              e.icon,
                              color: widget.selectedIndexNotifier.value == i
                                  ? AppcolorPallettes.kOrange
                                  : Colors.grey,
                              size: 20,
                            ),
                            Text(
                              e.initialValue,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: widget.selectedIndexNotifier.value == i
                                    ? AppcolorPallettes.kOrange
                                    : Colors.grey,
                                fontSize: 11.2.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.32,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
              .values,
        ],
      ),
      child: GestureDetector(
        onTap: popoverController.toggle,
        child: widget.child,
      ),
    );
  }
}
