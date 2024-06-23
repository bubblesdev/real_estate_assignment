import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sizer/sizer.dart';

import 'views/home_view/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return ShadApp.material(
          debugShowCheckedModeBanner: false,
          title: 'Sizer',
          materialThemeBuilder: (context, child) {
            return ThemeData(
              fontFamily: "Euclid Circular",
              useMaterial3: true,
            );
          },
          home: const HomeScreen(),
        );
      },
    );
  }
}
