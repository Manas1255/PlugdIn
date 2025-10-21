import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/core/models/navigation_item.dart';

class UserNavigation extends StatefulWidget {
  const UserNavigation({required this.shell, super.key});

  final StatefulNavigationShell shell;

  @override
  State<UserNavigation> createState() => _UserNavigationState();
}

class _UserNavigationState extends State<UserNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: widget.shell,
      bottomNavigationBar: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: 16,
        ),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -1),
            ),
          ],
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
            bottom: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(context, 0),
              _buildNavItem(context, 1),
              _buildNavItem(context, 2),
            ],
          ),
        ),
      ),
    );
  }

  List<NavItem> get _navBarItems => [
    const NavItem(
      title: 'Home',
      icon: AssetPaths.homeUnselectedIcon,
      selectedIcon: AssetPaths.homeSelectedIcon,
    ),
    const NavItem(
      title: 'Search',
      icon: AssetPaths.searchUnselectedIcon,
      selectedIcon: AssetPaths.searchSelectedIcon,
    ),
    const NavItem(
      title: 'Profile',
      icon: AssetPaths.profileUnselectedIcon,
      selectedIcon: AssetPaths.profileSelectedIcon,
    ),
  ];

  Widget _buildNavItem(
    BuildContext context,
    int index,
  ) {
    final item = _navBarItems[index];
    final isSelected = index == widget.shell.currentIndex;

    return GestureDetector(
      onTap: () {
        widget.shell.goBranch(index, initialLocation: true);
      },

      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),

        child: SvgPicture.asset(
          isSelected ? item.selectedIcon : item.icon,
        ),
      ),
    );
  }
}
