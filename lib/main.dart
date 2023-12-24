import 'package:admin_ecommerce_app/screens/main/main_screen.dart';
import 'package:admin_ecommerce_app/shared/constants.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

// void main() => runApp(const MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyC4Izlm1Os4gcvBt0tpVdWNVptb2Xil10g',
          appId: "1:157498549475:android:7edeb5298027135a3251d6",
          messagingSenderId: '157498549475',
          projectId: 'flutter-ecommerce-app-2023',
          storageBucket: "flutter-ecommerce-app-2023.appspot.com"),
    );
    runApp(const MyApp());
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  runApp(DevicePreview(
      enabled: !kReleaseMode, builder: (context) => const MyApp()));
}

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
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: colorSecondary,
      ),
      home: const MainScreen(),
    );
  }
}
