import 'package:admin_ecommerce_app/models/menu.dart';
import 'package:admin_ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final _menus = [
  Menu(
      id: 'DA',
      title: 'Bảng điều khiển',
      icon: 'assets/icons/menu_dashbord.svg'),
  Menu(id: 'OR', title: 'Đơn hàng', icon: 'assets/icons/order.svg'),
  Menu(id: 'PR', title: 'Sản phẩm', icon: 'assets/icons/menu_product.svg'),
  Menu(id: 'LO', title: 'Đăng xuất', icon: 'assets/icons/menu_logout.svg'),
];

class SideMenu extends StatelessWidget {
  const SideMenu(this.selectedMenuId, this.onMenuSelected, {super.key});

  final String selectedMenuId;
  final void Function(String) onMenuSelected;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(child: Image.asset("assets/images/logoShop.png")),
          for (var menu in _menus)
            ListTile(
              leading: SvgPicture.asset(menu.icon,
                  colorFilter:
                      const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
                  height: 20),
              title: Text(menu.title),
              textColor: Colors.white54,
              selectedColor: colorPrimary,
              selected: menu.id == selectedMenuId,
              onTap: () async {
                onMenuSelected(menu.id);
                Navigator.pop(context); // Close the drawer.
              },
            ),
        ],
      ),
    );
  }
}
