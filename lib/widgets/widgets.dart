import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Index of the selected tab

  List<Widget> _pages = [
    // Add your page content here
    Center(child: Text('House')),
    Center(child: Text('Apartment')),
    Center(child: Text('Hotel')),
    Center(child: Text('Villa')),
    Center(child: Text('Cottage')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            color: Colors.blue,
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem('House', Icons.home),
                  _buildNavItem('Apartment', Icons.apartment),
                  _buildNavItem('Hotel', Icons.hotel),
                  _buildNavItem('Villa', Icons.villa),
                  _buildNavItem('Cottage', Icons.cottage),
                ],
              ),
            ),
          ),
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }

  Widget _buildNavItem(String label, IconData icon) {
    final isSelected = _pages.indexOf(label as Widget) == _selectedIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = _pages.indexOf(label as Widget);
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.white54,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}