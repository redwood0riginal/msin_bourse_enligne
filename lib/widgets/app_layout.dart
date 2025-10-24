import 'package:flutter/material.dart';
import '../screens/profile/menu_screen.dart';
import '../screens/news/news_screen.dart';
import '../screens/notifications/notifications_screen.dart';

class AppLayout extends StatelessWidget {
  final Widget body;
  final String title;
  final int? currentIndex;
  final Function(int)? onNavigationChanged;
  final bool showBottomNav;
  final List<Widget>? additionalActions;

  const AppLayout({
    super.key,
    required this.body,
    required this.title,
    this.currentIndex,
    this.onNavigationChanged,
    this.showBottomNav = true,
    this.additionalActions,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: isDarkMode ? const Color(0xFF0A0E21) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xFF1A1F3A) : Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu_rounded,
            color: isDarkMode ? Colors.white : const Color(0xFF0A0E21),
            size: 28,
          ),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isDarkMode ? Colors.white : const Color(0xFF0A0E21),
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          ...(additionalActions ?? []),
          IconButton(
            icon: Icon(
              Icons.article_outlined,
              color: isDarkMode ? Colors.white : const Color(0xFF0A0E21),
              size: 26,
            ),
            onPressed: () {
              // Check if we're not already on the news screen
              if (title != 'Actualités') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewsScreen()),
                );
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: isDarkMode ? Colors.white : const Color(0xFF0A0E21),
              size: 26,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: const MenuScreen(),
      body: body,
      bottomNavigationBar:
          showBottomNav && currentIndex != null && onNavigationChanged != null
              ? CustomBottomNavBar(
                currentIndex: currentIndex!,
                onNavigationChanged: onNavigationChanged!,
                isDarkMode: isDarkMode,
              )
              : null,
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onNavigationChanged;
  final bool isDarkMode;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onNavigationChanged,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1A1F3A) : Colors.white,
        boxShadow: [
          BoxShadow(
            color:
                isDarkMode
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_rounded,
                label: 'Accueil',
                index: 0,
              ),
              _buildNavItem(
                icon: Icons.show_chart_rounded,
                label: 'Marché',
                index: 1,
              ),
              _buildNavItem(
                icon: Icons.account_balance_wallet_rounded,
                label: 'Portefeuille',
                index: 2,
              ),
              _buildNavItem(
                icon: Icons.receipt_long_rounded,
                label: 'Transactions',
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = currentIndex == index;
    final color =
        isSelected
            ? const Color(0xFF1565C0)
            : isDarkMode
            ? Colors.white.withOpacity(0.5)
            : const Color(0xFF64748B);

    return Expanded(
      child: GestureDetector(
        onTap: () => onNavigationChanged(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? const Color(0xFF1565C0).withOpacity(0.1)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 26),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
