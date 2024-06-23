import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:real_estate_ui/constants/color_palletes.dart';
import 'package:real_estate_ui/views/map_view/widget/popover_page.dart';

class StateBuilder extends StatefulWidget {
  final ValueNotifier<int> selectedIndexNotifier;
  const StateBuilder({super.key, required this.selectedIndexNotifier});

  @override
  State<StateBuilder> createState() => _StateBuilderState();
}

class _StateBuilderState extends State<StateBuilder> {
  @override
  Widget build(BuildContext context) {
    // Retrieve the PopoverPageState
    final popoverState = context.findAncestorStateOfType<PopoverPageState>();

    if (popoverState == null) {
      // Handle null case
      return Container();
    }

    return ValueListenableBuilder<int>(
      valueListenable: widget.selectedIndexNotifier,
      builder: (context, selectedIndex, child) {
        final currentIcon = popoverState.layer[selectedIndex].icon;
        return ClipOval(
          child: Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            color: Colors.grey.withOpacity(0.8),
            child: FaIcon(
              currentIcon,
              color: AppcolorPallettes.kwhite.withOpacity(0.6),
              size: 20,
            ),
          ),
        ).animate().scaleXY(duration: 500.ms);
      },
    );
  }
}
