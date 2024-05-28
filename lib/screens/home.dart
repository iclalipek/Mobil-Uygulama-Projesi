import 'package:flutter/material.dart';
import 'package:mobile_project/components/home_items.dart';
import 'package:mobile_project/screens/product_screen.dart';
import 'package:mobile_project/screens/profile.dart';

class MenuItem {
  final IconData icon;
  final String title;
  final Widget page;

  const MenuItem({required this.icon, required this.title, required this.page});
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<MenuItem> _menuItems = const [
    MenuItem(icon: Icons.home, title: 'Anasayfa', page: HomeItemScreen()),
    MenuItem(
        icon: Icons.add_circle_outline,
        title: 'Ürün Ekle',
        page: ProductAddScreen()),
    MenuItem(
        icon: Icons.shopping_cart,
        title: 'Sepetim',
        page: Center(child: Text('Sepet'))),
    MenuItem(icon: Icons.person, title: 'Profil', page: Profile()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 32,
        items: _menuItems
            .map((e) => BottomNavigationBarItem(
                  backgroundColor: Colors.purple,
                  icon: Icon(e.icon),
                  label: e.title,
                  tooltip: e.title,
                ))
            .toList(),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _menuItems[_selectedIndex].page,
    );
  }
}
