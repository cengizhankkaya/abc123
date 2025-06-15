import 'package:flutter/material.dart';

class BottomNavigatorBar extends StatefulWidget {
  final Function(int) onItemTapped;

  const BottomNavigatorBar({
    super.key,
    required this.onItemTapped,
  });

  @override
  State<BottomNavigatorBar> createState() => _BottomNavigatorBarState();
}

class _BottomNavigatorBarState extends State<BottomNavigatorBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onItemTapped(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Sol ikon - Gazete/Belge
          _buildNavItem(0, Icons.article_outlined),

          // Orta ikon - Yeşil Artı Butonu
          _buildCenterButton(1),

          // Sağ ikon - Bina
          _buildNavItem(2, Icons.abc_rounded),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon) {
    final isSelected = _selectedIndex == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: EdgeInsets.all(isSelected ? 10 : 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: IconButton(
        onPressed: () => _onItemTapped(index),
        icon: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child: Icon(
            icon,
            color: isSelected ? const Color(0xFF546E7A) : Colors.grey,
            size: isSelected ? 30 : 28,
          ),
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildCenterButton(int index) {
    final isSelected = _selectedIndex == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isSelected ? 60 : 55,
      height: isSelected ? 60 : 55,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(isSelected ? 0.3 : 0.2),
            spreadRadius: isSelected ? 2 : 1,
            blurRadius: isSelected ? 8 : 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: isSelected ? 45 : 40,
          height: isSelected ? 45 : 40,
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            onPressed: () => _onItemTapped(index),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 22,
            ),
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
