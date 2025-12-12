import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/navbar.dart';
import '../widgets/background.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ContactContent(),
          ),
        ),
      ),
    );
  }
}

class ContactContent extends StatefulWidget {
  const ContactContent({super.key});

  @override
  State<ContactContent> createState() => _ContactContentState();
}

class _ContactContentState extends State<ContactContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final double angle = _controller.value * 2 * pi;
        final double dx = cos(angle) * 10;
        final double dy = sin(angle) * 10;

        return LayoutBuilder(
          builder: (context, constraints) {
            final bool isMobile = constraints.maxWidth < 750;

            return Container(
              width: isMobile ? size.width * 0.95 : 1100,
              height: isMobile ? null : 650,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1D),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Color.lerp(
                      Colors.cyanAccent,
                      Colors.blueAccent,
                      (sin(angle) + 1) / 2,
                    )!.withOpacity(0.45 + 0.1 * sin(angle)),
                    blurRadius: 40 + 10 * sin(angle),
                    offset: Offset(-dx, -dy),
                  ),
                  BoxShadow(
                    color: Color.lerp(
                      Colors.pinkAccent,
                      Colors.purpleAccent,
                      (cos(angle) + 1) / 2,
                    )!.withOpacity(0.45 + 0.1 * cos(angle)),
                    blurRadius: 40 + 10 * cos(angle),
                    offset: Offset(dx, dy),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: NavBar(),
                  ),
                  Expanded(
                    child:
                        isMobile
                            ? _buildMobileLayout(context)
                            : _buildWebLayout(context),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // 🌐 WEB LAYOUT (Side-by-side, vertically centered)
  // 🌐 WEB LAYOUT (Centered side-by-side layout)
  Widget _buildWebLayout(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔹 Left – Contact buttons (slightly centered)
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _animatedContactCard(
                      icon: Icons.email_rounded,
                      label: "Email",
                      url: "mailto:jothikrishnanrameshbabu@gmail.com",
                      color: Colors.cyanAccent,
                    ),
                    const SizedBox(height: 25),
                    _animatedContactCard(
                      icon: Icons.work_outline_rounded,
                      label: "LinkedIn",
                      url: "https://www.linkedin.com/in/jothikrishnan09/",
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(height: 25),
                    _animatedContactCard(
                      icon: Icons.camera_alt_outlined,
                      label: "Instagram",
                      url: "https://www.instagram.com/jothi_p_r/",
                      color: Colors.pinkAccent,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 80),

            // 🔹 Right – Info (centered vertically)
            Expanded(
              flex: 5,
              child: Align(
                alignment: Alignment.centerLeft,
                child: _contactDetailsSection(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 📱 MOBILE LAYOUT (Vertical stack)
  // 📱 MOBILE LAYOUT (Vertical stack)
  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           LayoutBuilder(
                        builder: (context, constraints) {
                          double screenWidth = constraints.maxWidth;

                          // Responsive text size
                          double fontSize =
                              screenWidth < 600
                                  ? 24 // small screens (mobile)
                                  : screenWidth < 900
                                  ? 26 // tablets
                                  : 30; // desktops

                          return Text(
                            "Let’s Connect",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),

          SizedBox(height: 10),
          SizedBox(
            width: 100,
            height: 3,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.cyanAccent),
            ),
          ),
          SizedBox(height: 20),
          // 🔹 Contact Buttons
          _animatedContactCard(
            icon: Icons.email_rounded,
            label: "Email",
            url: "mailto:jothikrishnanrameshbabu@gmail.com",
            color: Colors.cyanAccent,
          ),
          const SizedBox(height: 20),
          _animatedContactCard(
            icon: Icons.work_outline_rounded,
            label: "LinkedIn",
            url: "https://www.linkedin.com/in/jothikrishnan09/",
            color: Colors.blueAccent,
          ),
          const SizedBox(height: 20),
          _animatedContactCard(
            icon: Icons.camera_alt_outlined,
            label: "Instagram",
            url: "https://www.instagram.com/jothi_p_r/",
            color: Colors.pinkAccent,
          ),

          const SizedBox(height: 40),

          // 🔹 Contact Info (short + clean)
          const Text(
            "📧 jothikrishnanrameshbabu@gmail.com\n📞 +91 93457 19771",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.white70, height: 1.6),
          ),

          const SizedBox(height: 30),

          // 🔹 Description (without “Let’s Connect” title)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Thank you for reaching out!\n"
              "I look forward to connecting and creating something amazing together.\n"
              "Let’s make ideas come to life. 🚀",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white54,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✉️ Contact Info + Greeting (shared by both layouts)
  Widget _contactDetailsSection() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let’s Connect",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          width: 100,
          height: 3,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.cyanAccent),
          ),
        ),
        SizedBox(height: 30),
        Text(
          "📧 Email: jothikrishnanrameshbabu@gmail.com",
          style: TextStyle(fontSize: 16, color: Colors.white70),
        ),
        SizedBox(height: 15),
        Text(
          "📞 Contact: +91 93457 19771",
          style: TextStyle(fontSize: 16, color: Colors.white70),
        ),
        SizedBox(height: 50),
        Text(
          "Thank you for reaching out!\n"
          "I look forward to connecting and creating something amazing together.\n"
          "Let’s make ideas come to life. 🚀",
          style: TextStyle(fontSize: 16, color: Colors.white54, height: 1.6),
        ),
      ],
    );
  }

  // 💡 Animated Contact Card Widget
  static Widget _animatedContactCard({
    required IconData icon,
    required String label,
    required String url,
    required Color color,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.9, end: 1.0),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => HapticFeedback.lightImpact(),
            child: GestureDetector(
             onTap: () async {
  Uri uri;

  if (url.startsWith('mailto:')) {
    // Properly encode mailto URI for better compatibility
    uri = Uri(
      scheme: 'mailto',
      path: 'jothikrishnanrameshbabu@gmail.com',
      query: Uri.encodeFull('subject=Hello Jothikrishnan&body=Hi,'),
    );
  } else {
    uri = Uri.parse(url);
  }

  // Use platformDefault so it works on both mobile & web
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  } else {
    debugPrint("⚠️ Could not launch $uri");
  }
},

              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: color.withOpacity(0.5), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: color, size: 26),
                    const SizedBox(width: 12),
                    Text(
                      label,
                      style: TextStyle(
                        color: color,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
