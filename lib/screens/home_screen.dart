import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/navbar.dart';
import '../widgets/background.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        child: const Center(
          child: Padding(padding: EdgeInsets.all(20.0), child: HomeContent()),
        ),
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>
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

  // 🌐 WEB LAYOUT (same as your current one)
  Widget _buildWebLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // LEFT SIDE TEXT
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: _introTextSection(),
          ),
        ),

        // RIGHT SIDE PROFILE IMAGE
        const Expanded(flex: 1, child: Center(child: AnimatedGlowProfile())),
      ],
    );
  }

  // 📱 MOBILE LAYOUT (stacked vertically)
  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Profile Image on top
          const AnimatedGlowProfile(),
          const SizedBox(height: 40),

          // Intro Text Below
          _introTextSection(isMobile: true),
        ],
      ),
    );
  }

  // 🔹 Common Intro Text Section
  // inside your _introTextSection() widget
  Widget _introTextSection({bool isMobile = false}) {
    final double titleSize = isMobile ? 24 : 40;
    final double subtitleSize = isMobile ? 16 : 20;
    final double greetingSize = isMobile ? 22 : 24;

    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Greeting line
        Text(
          "Hi there!!",
          style: TextStyle(fontSize: greetingSize, color: Colors.white70),
        ),

        const SizedBox(height: 10),

        // Name line
        RichText(
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          text: TextSpan(
            children: [
              TextSpan(
                text: "I'm ",
                style: TextStyle(fontSize: greetingSize, color: Colors.white70),
              ),
              TextSpan(
                text: "JOTHIKRISHNAN P R",
                style: GoogleFonts.poppins(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.purpleAccent.withOpacity(0.5),
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // 💫 Animated Role Texts
        DefaultTextStyle(
          style: TextStyle(
            fontSize: subtitleSize,
            fontWeight: FontWeight.bold,
            color: Colors.cyanAccent,
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            pause: const Duration(milliseconds: 500),
            animatedTexts: [
              TypewriterAnimatedText(
                'Full Stack Developer',
                speed: const Duration(milliseconds: 90),
              ),
              TypewriterAnimatedText(
                'Application & Web Developer',
                speed: const Duration(milliseconds: 90),
              ),
              TypewriterAnimatedText(
                'Flutter & Java Enthusiast',
                speed: const Duration(milliseconds: 90),
              ),

              TypewriterAnimatedText(
                'Software Engineer ',
                speed: const Duration(milliseconds: 90),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Intro paragraph
        Text(
          "I build modern mobile and web apps with Flutter and continuously explore new technologies.",
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 16,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 30),

        // ✅ Button
        isMobile
            ? Center(child: _downloadCVButton())
            : Align(
              alignment: Alignment.centerLeft,
              child: _downloadCVButton(),
            ),
      ],
    );
  }

  // 🔹 Extracted the button into its own widget for cleaner code
  Widget _downloadCVButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.cyanAccent,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: () async {
        final Uri pdfUri = Uri.parse('resume.pdf'); // Relative to domain root
        if (!await launchUrl(pdfUri, mode: LaunchMode.externalApplication)) {
          debugPrint("❌ Could not open ${pdfUri.toString()}");
        }
      },

      // onPressed: () async {
      //   final Uri pdfUri = Uri.parse('assets/resume.pdf');
      //   if (!await launchUrl(pdfUri)) {
      //     debugPrint("❌ Could not open ${pdfUri.toString()}");
      //   }
      // },
      icon: const Icon(Icons.download),
      label: const Text("Download CV"),
    );
  }
}

// 💫 Animated Glow Profile (no change)
class AnimatedGlowProfile extends StatefulWidget {
  const AnimatedGlowProfile({super.key});

  @override
  State<AnimatedGlowProfile> createState() => _AnimatedGlowProfileState();
}

class _AnimatedGlowProfileState extends State<AnimatedGlowProfile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final double angle = _controller.value * 2 * pi;
        final double dx = cos(angle) * 10;
        final double dy = sin(angle) * 10;
        final double glow = (sin(angle) + 1) / 2;

        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color.lerp(
                  Colors.pinkAccent,
                  Colors.purpleAccent,
                  (sin(angle) + 1) / 2,
                )!.withOpacity(0.5 + glow * 0.3),
                blurRadius: 20 + glow * 10,
                spreadRadius: 2 + glow * 3,
                offset: Offset(-dx, -dy),
              ),
              BoxShadow(
                color: Color.lerp(
                  Colors.cyanAccent,
                  Colors.blueAccent,
                  (cos(angle) + 1) / 2,
                )!.withOpacity(0.5 + glow * 0.3),
                blurRadius: 20 + glow * 10,
                spreadRadius: 2 + glow * 3,
                offset: Offset(dx, dy),
              ),
            ],
          ),
          child: const CircleAvatar(
            radius: 130,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
        );
      },
    );
  }
}
