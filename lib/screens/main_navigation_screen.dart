import 'package:flutter/material.dart';
import '../widgets/app_layout.dart';
import 'home_screen.dart';
import 'market/market_screen.dart';
import 'portfolio_screen.dart';
import 'trading/transactions_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const MarketScreen(),
    const PortfolioScreen(),
    const TransactionsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: _getTitle(),
      currentIndex: _currentIndex,
      onNavigationChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      body: _screens[_currentIndex],
    );
  }

  String _getTitle() {
    switch (_currentIndex) {
      case 0:
        return 'M.S.IN Bourse';
      case 1:
        return 'Marché';
      case 2:
        return 'Portefeuille';
      case 3:
        return 'Transactions';
      default:
        return 'M.S.IN Bourse';
    }
  }
}
