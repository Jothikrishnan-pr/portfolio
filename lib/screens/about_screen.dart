import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/background.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        child: const Center(
          child: Padding(padding: EdgeInsets.all(20.0), child: AboutContent()),
        ),
      ),
    );
  }
}

class AboutContent extends StatefulWidget {
  const AboutContent({super.key});

  @override
  State<AboutContent> createState() => _AboutContentState();
}

class _AboutContentState extends State<AboutContent>
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

  // 🌐 WEB LAYOUT
  Widget _buildWebLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _sectionTitle("About Me", Colors.white),
          const SizedBox(height: 20),
          const Text(
            "I’m a tech enthusiast and aspiring software developer skilled in Java and Flutter. "
            "I love building creative, responsive, and functional applications that make everyday tasks easier. "
            "My goal is to become a full-stack developer and work on impactful projects that combine innovation, "
            "performance, and design.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, height: 1.6, color: Colors.white70),
          ),
          const SizedBox(height: 40),
          _sectionTitle("Skills", Colors.cyanAccent),
          const SizedBox(height: 40),
          _buildSkillWrap(),
        ],
      ),
    );
  }

  // 📱 MOBILE LAYOUT
  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _sectionTitle("About Me", Colors.white),
          const SizedBox(height: 20),
          const Text(
            "I’m a tech enthusiast and aspiring software developer skilled in Java and Flutter. "
            "I love building creative, responsive, and functional applications that make everyday tasks easier. "
            "My goal is to become a full-stack developer and work on impactful projects that combine innovation, "
            "performance, and design.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, height: 1.6, color: Colors.white70),
          ),
          const SizedBox(height: 40),
          _sectionTitle("Skills", Colors.cyanAccent),
          const SizedBox(height: 30),
          _buildSkillWrap(),
        ],
      ),
    );
  }

  // 🔹 Section Title Widget
  Widget _sectionTitle(String text, Color color) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            double fontSize =
                screenWidth < 600
                    ? 24
                    : screenWidth < 900
                    ? 26
                    : 30;
            return Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 100,
          height: 3,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.cyanAccent),
          ),
        ),
      ],
    );
  }

  // 🧩 Skills Grid
  Widget _buildSkillWrap() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 20,
      runSpacing: 20,
      children: const [
        AnimatedSkillCard(
          title: "Programming Languages",
          icon: Icons.code_rounded,
          skills: ["Java", "SQL", "Dart", "HTML", "CSS"],
        ),
        AnimatedSkillCard(
          title: "Frameworks & Technologies",
          icon: Icons.developer_board_rounded,
          skills: ["Flutter", "Node.js", "MongoDB"],
        ),
        AnimatedSkillCard(
          title: "Design & Creative Tools",
          icon: Icons.brush_rounded,
          skills: ["Canva", "Figma"],
        ),
        AnimatedSkillCard(
          title: "Tools & IDEs",
          icon: Icons.terminal_rounded,
          skills: ["Android Studio", "VS Code", "Postman", "Git"],
        ),
      ],
    );
  }
}

// ✨ Skill Card (same as before)
class AnimatedSkillCard extends StatefulWidget {
  final String title;
  final List<String> skills;
  final IconData icon;

  const AnimatedSkillCard({
    super.key,
    required this.title,
    required this.skills,
    required this.icon,
  });

  @override
  State<AnimatedSkillCard> createState() => _AnimatedSkillCardState();
}

class _AnimatedSkillCardState extends State<AnimatedSkillCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final Matrix4 baseTransform = Matrix4.identity();
    final Matrix4 hoverTransform =
        Matrix4.identity()
          ..scale(1.07)
          ..rotateX(0.02)
          ..rotateY(-0.03);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        child: Transform(
          alignment: Alignment.center,
          transform: _hovering ? hoverTransform : baseTransform,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            width: 230,
            height: 280,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.06),
                  Colors.cyanAccent.withOpacity(0.02),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color:
                    _hovering
                        ? Colors.cyanAccent.withOpacity(0.7)
                        : Colors.cyanAccent.withOpacity(0.18),
                width: _hovering ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.cyanAccent.withOpacity(_hovering ? 0.4 : 0.0),
                  blurRadius: _hovering ? 40 : 0,
                  spreadRadius: _hovering ? 2 : 0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedRotation(
                  turns: _hovering ? 0.05 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  child: Icon(widget.icon, color: Colors.cyanAccent, size: 30),
                ),
                const SizedBox(height: 15),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        widget.skills
                            .map(
                              (skill) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.cyanAccent.withOpacity(0.10),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  skill,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
