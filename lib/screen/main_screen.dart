import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'add_activity_screen.dart';
import 'history_screen.dart';
import 'bmiscreen.dart';

/// MainScreen — App ka navigation shell.
///
/// Bottom Navigation Bar ke through 4 tabs accessible hain:
/// 0: Dashboard   — Today's fitness stats
/// 1: Add Activity — Workout record karne ka form
/// 2: History      — Sabhi activities ki list
/// 3: BMI          — Existing BMI Calculator
///
/// IndexedStack use kiya hai taaki tab switch karne pe state maintain ho
/// (e.g., Add Activity form ka data lose na ho jab Dashboard pe jayein).
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Currently selected tab ka index
  int _currentIndex = 0;

  /// Tab switch karne ka method — bottom nav aur Dashboard button dono use karenge
  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Screens list — har index ek tab hai
    final screens = [
      // Tab 0: Dashboard — onAddActivity callback se tab 1 pe switch hoga
      DashboardScreen(onAddActivity: () => _onTabSelected(1)),
      // Tab 1: Add Activity form
      const AddActivityScreen(),
      // Tab 2: All activities history
      const HistoryScreen(),
      // Tab 3: Existing BMI Calculator (nameForHome optional hai ab)
      const BMIScreen(),
    ];

    return Scaffold(
      // IndexedStack — sabhi children ek saath build hote hain
      // but sirf selected index wala dikhta hai.
      // Benefit: jab tab switch karo, state preserve rehta hai.
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),

      // --- Bottom Navigation Bar ---
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
        // 'fixed' type ensures all labels always visible
        // (default 'shifting' type hides unselected labels when >3 items)
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: 'Add Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_weight_outlined),
            activeIcon: Icon(Icons.monitor_weight),
            label: 'BMI',
          ),
        ],
      ),
    );
  }
}
