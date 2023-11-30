import 'package:admin_ecommerce_app/screens/main/main_screen.dart';
import 'package:admin_ecommerce_app/shared/constants.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// void main() => runApp(const MyApp());
void main() => runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce Admin App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: colorBackground,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.white),
        canvasColor: colorSecondary,
      ),
      home: const MainScreen(),
    );
  }
}
