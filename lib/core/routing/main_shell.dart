import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // navigationShell هو المكان الذي ستُعرض فيه الشاشات الخمسة
      body: navigationShell,
      
      // الشريط السفلي الثابت
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          // هذا الأمر يقوم بتبديل الشاشة دون إخفاء الشريط
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.accentGreen,
        unselectedItemColor: isDark ? Colors.white60 : Colors.black45,
        selectedLabelStyle: AppTypography.labelSmall,
        unselectedLabelStyle: AppTypography.caption,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'الخدمات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: 'طلباتي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center_outlined),
            label: 'مشاريعنا',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz_rounded),
            label: 'المزيد',
          ),
        ],
      ),
    );
  }
}
