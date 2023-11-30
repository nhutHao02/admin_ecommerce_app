import 'package:admin_ecommerce_app/models/user.dart';
import 'package:admin_ecommerce_app/screens/dashboard/dashboard_screen.dart';
import 'package:admin_ecommerce_app/screens/login/login_screen.dart';
import 'package:admin_ecommerce_app/screens/main/header.dart';
import 'package:admin_ecommerce_app/screens/main/side_menu.dart';
import 'package:admin_ecommerce_app/screens/orders/orders_screen.dart';
import 'package:admin_ecommerce_app/screens/products/products_screen.dart';
import 'package:admin_ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final screens = <String, Widget>{
    'DA': const DashboardScreen(),
    'OR': const OrdersScreen(),
    'PR': const ProductScreen(),
  };

  User? currentUser;
  late var currentScreenId = 'LI';

  Widget get currentScreen => screens[currentScreenId]!;

  void onMenuSelected(String menuId) {
    if (menuId != 'LO') {
      setState(() => currentScreenId = menuId);
    } else {
      setState(() {
        currentUser = null;
        currentScreenId = 'LI';
      });
    }
  }

  void onUserSignedIn(User? user) {
    if (user != null) {
      setState(() {
        currentUser = user;
        currentScreenId = 'DA';
      });
    }
  }

  void openMenu() {
    if (!scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  void initState() {
    screens['LI'] = LoginScreen(onUserSignedIn);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: SideMenu(currentScreenId, onMenuSelected),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (currentUser != null) Header(currentUser: currentUser!, openMenuCallback: openMenu),
                    const SizedBox(height: defaultPadding),
                    currentScreen
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
