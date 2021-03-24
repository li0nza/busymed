import 'package:busymed_assessment/repository/products.dart';
import 'package:busymed_assessment/views/favourites.dart';
import 'package:busymed_assessment/views/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsRepository()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  Color primaryColor = Color(0xFFdf1745);
  Color accentColor = Color(0xFF2d405a);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          primaryColor: primaryColor,
          accentColor: accentColor,
        ),
        home: Scaffold(
          body: Center(child: _getCurrentWidget()),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt),
                activeIcon: Icon(Icons.list_alt),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                activeIcon: Icon(Icons.favorite),
                label: 'Favourites',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: primaryColor,
            unselectedItemColor: Colors.white,
            backgroundColor: accentColor,
            onTap: _onItemTapped,
          ),
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getCurrentWidget() {
    if (_selectedIndex == 0) return ProductsWidget();
    return FavouritesWidget();
  }
}
