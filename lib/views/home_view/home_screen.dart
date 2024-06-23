import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:real_estate_ui/constants/color_palletes.dart';
import 'package:real_estate_ui/views/home_view/widget/custom_tab_bar.dart';
import 'package:real_estate_ui/views/map_view/map_view.dart';
import 'package:sizer/sizer.dart';

import 'widget/custom_sliver_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final GlobalKey<CustomSliverAppBarState> globalKey =
    GlobalKey<CustomSliverAppBarState>();

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _appBarController;
  late Animation<double> _locationBoxAnimation;
  late Animation<double> _avatarScaleAnimation;

  late final List<Widget> _screens;

  int _selectedTab = 2;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _appBarController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _locationBoxAnimation = Tween<double>(begin: 0.0, end: 140.sp).animate(
      CurvedAnimation(
        parent: _appBarController,
        curve: Curves.ease,
      ),
    );
    _avatarScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _appBarController,
        curve: Curves.ease,
      ),
    );

    _appBarController.forward();

    _screens = [
      const MapView(),
      const ChatView(),
      HomeTabView(
        appBarController: _appBarController,
        locationBoxAnimation: _locationBoxAnimation,
        avatarScaleAnimation: _avatarScaleAnimation,
        key: globalKey,
      ),
      const NotifView(),
      const UserView(),
    ];
  }

  @override
  void dispose() {
    _appBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      bottomNavigationBar: CustomTabBar(
        selectedTab: _selectedTab,
        onTabChange: (int tabIndex) {
          setState(() {
            _selectedTab = tabIndex;
          });
        },
      )
          .animate(delay: 6000.ms)
          .slideY(begin: 1, end: 0.2, duration: 700.ms, curve: Curves.easeIn),
      extendBody: true,
      backgroundColor: Colors.white,
      body: _screens.elementAt(_selectedTab),
    );
  }
}

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("User"),
      ),
    );
  }
}

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Chat"),
      ),
    );
  }
}

class NotifView extends StatelessWidget {
  const NotifView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Notification"),
      ),
    );
  }
}

class HomeTabView extends StatefulWidget {
  const HomeTabView({
    super.key,
    required AnimationController appBarController,
    required Animation<double> locationBoxAnimation,
    required Animation<double> avatarScaleAnimation,
  })  : _appBarController = appBarController,
        _locationBoxAnimation = locationBoxAnimation,
        _avatarScaleAnimation = avatarScaleAnimation;

  final AnimationController _appBarController;
  final Animation<double> _locationBoxAnimation;
  final Animation<double> _avatarScaleAnimation;

  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppcolorPallettes.kdarkGrey.withOpacity(0.07),
            AppcolorPallettes.kOrange.withOpacity(0.3),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.05, 0.9],
        ),
      ),
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            sliver: AnimatedBuilder(
              animation: widget._appBarController,
              builder: (context, child) => CustomSliverAppBar(
                locationBoxAnimation: widget._locationBoxAnimation,
                avatarScaleAnimation: widget._avatarScaleAnimation,
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: _SliverHeaderDelegate(
              minHeight: 0,
              maxHeight: 70.h,
              child: Container(
                      padding: EdgeInsets.fromLTRB(3.w, 1.h, 3.w, 3.h),
                      decoration: const BoxDecoration(
                        color: AppcolorPallettes.kwhite,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/images/image1.jpg",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: _buildSlider(
                                  3000.ms, 2000.ms, "Gladkova St., 25"),
                            ),
                          ),
                          Gap(2.w),
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          "assets/images/image2.jpg",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: _buildSlider(
                                        3500.ms, 2500.ms, "Gubina St., 11"),
                                  ),
                                ),
                                Gap(2.w),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                "assets/images/image3.jpg",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: _buildSlider(3600.ms, 2200.ms,
                                              "Trefoleva St., 43"),
                                        ),
                                      ),
                                      Gap(2.w),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                "assets/images/image3.jpg",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: _buildSlider(2500.ms, 2000.ms,
                                              "Sedova St., 22"),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ))
                  .animate()
                  .slideY(begin: 1, end: 0, duration: 700.ms, delay: 1800.ms),
            ),
          ),
        ],
      ),
    );
  }

  LayoutBuilder _buildSlider(Duration delay1, Duration delay2, String address) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            Positioned(
              bottom: 10,
              child: ClipOval(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white.withOpacity(0.8),
                  height: 50,
                  width: 50,
                  child: FaIcon(
                    FontAwesomeIcons.paperPlane,
                    color: AppcolorPallettes.kdarkGrey.withOpacity(0.8),
                    size: 18,
                  ),
                ),
              )
                  .animate()
                  .then(
                    delay: delay1,
                  )
                  .custom(
                    duration: 1500.ms,
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Container(
                            height: 55,
                            padding: EdgeInsets.only(left: 1.w),
                            alignment: constraints.maxWidth > 200
                                ? Alignment.center
                                : Alignment.centerLeft,
                            width: (55 + ((constraints.maxWidth - 55) * value)),
                            decoration: BoxDecoration(
                              color: AppcolorPallettes.kwhite.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              address,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12.2.sp,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.032),
                            ).animate(delay: 4500.ms).fadeIn(),
                          ),
                          child,
                        ],
                      );
                    },
                  )
                  .animate()
                  .then(delay: delay2)
                  .scaleXY(
                    duration: 1000.ms,
                    curve: Curves.easeInOut,
                  ),
            ),
          ],
        );
      },
    );
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: child,
    );
  }

  @override
  bool shouldRebuild(_SliverHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // Create a circular path using the shorter dimension to ensure the circle fits within the container
    path.addOval(Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.shortestSide / 2,
    ));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}