import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:real_estate_ui/constants/color_palletes.dart';
import 'package:real_estate_ui/views/map_view/widget/popover_page.dart';
import 'package:real_estate_ui/views/map_view/widget/state_builder.dart';
import 'package:latlong2/latlong.dart' as lat;
import 'package:sizer/sizer.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final TextEditingController searchGiftController = TextEditingController();
  ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(0);

  @override
  void dispose() {
    selectedIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      body: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: selectedIndexNotifier,
            builder: (BuildContext context, int value, Widget? child) {
              return FlutterMap(
                options: const MapOptions(
                  initialCenter: lat.LatLng(59.9308, 30.3624),
                  initialZoom: 12.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png?api_key=74b06209-953a-4c95-a7ae-29a104749088",
                    userAgentPackageName: 'com.example.app',
                    retinaMode: RetinaMode.isHighDensity(context),
                    additionalOptions: const {
                      'api_key': "74b06209-953a-4c95-a7ae-29a104749088"
                    },
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: const lat.LatLng(59.9308, 30.3624),
                        height: value == 3 ? 35 : 35,
                        width: value == 3 ? 30 : 65,
                        child: _buildMarkerContainer(value),
                      ),
                      Marker(
                        point: const lat.LatLng(59.9402, 30.3923),
                        height: value == 3 ? 35 : 35,
                        width: value == 3 ? 30 : 65,
                        child: _buildMarkerContainer(value),
                      ),
                      Marker(
                        point: const lat.LatLng(59.9302, 30.3923),
                        height: value == 3 ? 35 : 35,
                        width: value == 3 ? 30 : 65,
                        child: _buildMarkerContainer(value),
                      ),
                      Marker(
                        point: const lat.LatLng(59.9102, 30.3123),
                        height: value == 3 ? 35 : 35,
                        width: value == 3 ? 30 : 65,
                        child: _buildMarkerContainer(value),
                      ),
                      Marker(
                        point: const lat.LatLng(59.9102, 30.3923),
                        height: value == 3 ? 35 : 35,
                        width: value == 3 ? 30 : 65,
                        child: _buildMarkerContainer(value),
                      ),
                      Marker(
                        point: const lat.LatLng(59.9202, 30.3223),
                        height: value == 3 ? 35 : 35,
                        width: value == 3 ? 30 : 65,
                        child: _buildMarkerContainer(value),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
          Positioned(
            top: 50,
            child: Container(
              height: 50,
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: SearchBar(
                      elevation: const WidgetStatePropertyAll(0),
                      backgroundColor: const WidgetStatePropertyAll(
                          AppcolorPallettes.kwhite),
                      hintText: "Saint Petersburg",
                      hintStyle: WidgetStatePropertyAll(
                        TextStyle(
                          letterSpacing: -0.36,
                          fontSize: 12.sp,
                          color: AppcolorPallettes.kblack.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      padding: const WidgetStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 16)),
                      leading: FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: AppcolorPallettes.kblack.withOpacity(0.6),
                        size: 20,
                      ),
                      controller: searchGiftController,
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                    ).animate().scaleXY(
                          duration: 500.ms,
                        ),
                  ),
                  Gap(2.2.w),
                  ClipOval(
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      color: AppcolorPallettes.kwhite,
                      child: FaIcon(
                        FontAwesomeIcons.sliders,
                        color: AppcolorPallettes.kblack.withOpacity(0.6),
                        size: 15,
                      ),
                    ),
                  ).animate().scaleXY(
                        duration: 500.ms,
                      ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 127,
            left: 20,
            child: Wrap(
              spacing: 10,
              direction: Axis.vertical,
              children: [
                PopoverPage(
                  selectedIndexNotifier: selectedIndexNotifier,
                  child: StateBuilder(
                    selectedIndexNotifier: selectedIndexNotifier,
                  ),
                ),
                ClipOval(
                  child: Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    color: Colors.grey.withOpacity(0.8),
                    child: FaIcon(
                      FontAwesomeIcons.paperPlane,
                      color: AppcolorPallettes.kwhite.withOpacity(0.6),
                      size: 18,
                    ),
                  ),
                ).animate().scaleXY(duration: 500.ms)
              ],
            ),
          ),
          Positioned(
            bottom: 127,
            right: 20,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey.withOpacity(0.8),
              ),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                children: [
                  FaIcon(
                    FontAwesomeIcons.burger,
                    color: AppcolorPallettes.kwhite.withOpacity(0.6),
                    size: 15,
                  ),
                  Text(
                    "List of variants",
                    style: TextStyle(
                      letterSpacing: -0.36,
                      fontSize: 12.sp,
                      color: AppcolorPallettes.kwhite.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ).animate().scaleXY(duration: 500.ms),
          )
        ],
      ),
    );
  }

  Widget _buildMarkerContainer(int value) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppcolorPallettes.kOrange,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: value == 3
          ? const Icon(
              Icons.cabin,
            )
          : null,
    ).animate(delay: 700.ms).scaleXY(
          duration: 500.ms,
        );
  }
}
