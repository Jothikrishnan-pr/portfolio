import 'package:flutter/material.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final String currentRoute = ModalRoute.of(context)?.settings.name ?? '/';
    final bool isMobile = MediaQuery.of(context).size.width < 700;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child:
          isMobile
              ? _buildMobileNav(context, currentRoute)
              : _buildWebNav(context, currentRoute),
    );
  }

  // 🌐 WEB / DESKTOP Navbar
  Widget _buildWebNav(BuildContext context, String currentRoute) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left side: Logo
        const Text(
          "Portfolio",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),

        // Right side: Navigation links
        Row(
          children: [
            _navButton(context, "Home", "/", currentRoute),
            _navButton(context, "About", "/about", currentRoute),
            _navButton(context, "Projects", "/projects", currentRoute),
            _navButton(context, "Contact", "/contact", currentRoute),
          ],
        ),
      ],
    );
  }

  // 📱 MOBILE Navbar (scrollable buttons)
  Widget _buildMobileNav(BuildContext context, String currentRoute) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Portfolio",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        // Scrollable Row of Nav Buttons
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _navButton(context, "Home", "/", currentRoute),
              _navButton(context, "About", "/about", currentRoute),
              _navButton(context, "Projects", "/projects", currentRoute),
              _navButton(context, "Contact", "/contact", currentRoute),
            ],
          ),
        ),
      ],
    );
  }

  // 🔹 Common Nav Button Widget
  Widget _navButton(
    BuildContext context,
    String title,
    String route,
    String currentRoute,
  ) {
    final bool isActive = currentRoute == route;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {
          if (!isActive) Navigator.pushNamed(context, route);
        },
        hoverColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.cyanAccent : Colors.white70,
                fontSize: 16,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 2,
              width: isActive ? 24 : 0,
              color: Colors.cyanAccent,
            ),
          ],
        ),
      ),
    );
  }
}
