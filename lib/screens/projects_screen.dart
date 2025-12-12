import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/background.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ProjectsContent(),
          ),
        ),
      ),
    );
  }
}

class ProjectsContent extends StatefulWidget {
  const ProjectsContent({super.key});

  @override
  State<ProjectsContent> createState() => _ProjectsContentState();
}

class _ProjectsContentState extends State<ProjectsContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat(reverse: true);
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
                    child: isMobile
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

  // 💻 Web / Desktop Layout
  Widget _buildWebLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40.0),
      child: _projectsContent(),
    );
  }

  // 📱 Mobile Layout
  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      child: _projectsContent(),
    );
  }

  // 🎯 Shared Content (both web & mobile)
  Widget _projectsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ---------- Major Projects ----------
        _sectionHeader("Major Projects", Colors.cyanAccent),
        const SizedBox(height: 40),
        _responsiveProjectGrid([
          const ProjectsCard(
            title: "Rental Tariff App - TravIT",
            description:
                "Developed a cab booking admin portal and travel planning platform using Flutter, focusing on front-end design, data handling, and user experience.",
            imagePath: "assets/images/travit.png",
            repoUrl: "https://nothing-notice.netlify.app/",
          ),
          const ProjectsCard(
            title: "E-commerce Site - Zero Brand",
            description:
                "Built a responsive e-commerce website for a dress shop with a modern, user-friendly interface optimized for both web and mobile.",
            imagePath: "assets/images/zero.png",
            repoUrl: "https://ecommerce-zerobrand.netlify.app/",
          ),
        ]),

        const SizedBox(height: 60),

        // ---------- Internship Tasks ----------
        _sectionHeader("Internship Tasks (Web Development)", Colors.pinkAccent),
        const SizedBox(height: 40),
        _responsiveProjectGrid([
          const ProjectsCard(
            title: "Tic-Tac-Toe Game",
            description:
                "An interactive Tic-Tac-Toe web app implementing dynamic gameplay and win detection using HTML, CSS, and JavaScript.",
            imagePath: "assets/images/tictac.png",
            repoUrl: "https://poetic-marshmallow-3d1e12.netlify.app/",
          ),
          const ProjectsCard(
            title: "Weather Web App",
            description:
                "A responsive weather web app integrating REST APIs for real-time weather insights and dynamic UI updates.",
            imagePath: "assets/images/weather.png",
            repoUrl: "https://dreamy-dodol-f3343f.netlify.app/",
          ),
          const ProjectsCard(
            title: "Stopwatch Web App",
            description:
                "Built a stopwatch app during internship with start, pause, reset, and lap time tracking features.",
            imagePath: "assets/images/stopwatch.png",
            repoUrl: "https://eloquent-crisp-ab5631.netlify.app/",
          ),
        ]),
      ],
    );
  }

  // 🔹 Section Header Widget
  Widget _sectionHeader(String title, Color color) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double fontSize = screenWidth < 600
            ? 24
            : screenWidth < 900
                ? 26
                : 30;

        return Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Container(width: 120, height: 3, color: color),
          ],
        );
      },
    );
  }

 // 🔹 Responsive Grid / Scroll for Projects
Widget _responsiveProjectGrid(List<Widget> cards) {
  final bool isMobile = MediaQuery.of(context).size.width < 750;

  if (isMobile) {
    // 📱 Stack cards vertically for mobile view
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < cards.length; i++) ...[
          cards[i],
          if (i != cards.length - 1) const SizedBox(height: 20),
        ],
      ],
    );
  } else {
    // 💻 Use grid-style layout for web / desktop
    return Wrap(
      spacing: 25,
      runSpacing: 25,
      alignment: WrapAlignment.center,
      children: cards,
    );
  }
}
  }

class ProjectsCard extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;
  final String repoUrl;

  const ProjectsCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.repoUrl,
  });

  @override
  State<ProjectsCard> createState() => _ProjectsCardState();
}

class _ProjectsCardState extends State<ProjectsCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        transform: _isHovered
            ? (Matrix4.identity()
              ..scale(1.05)
              ..translate(0, -8))
            : Matrix4.identity(),
        width: 280,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? Colors.cyanAccent.withOpacity(0.6)
                : Colors.cyanAccent.withOpacity(0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? Colors.cyanAccent.withOpacity(0.3)
                  : Colors.cyanAccent.withOpacity(0.1),
              blurRadius: _isHovered ? 20 : 10,
              spreadRadius: _isHovered ? 2 : 1,
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () async {
            final Uri uri = Uri.parse(widget.repoUrl);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(widget.imagePath, fit: BoxFit.contain),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.cyanAccent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
