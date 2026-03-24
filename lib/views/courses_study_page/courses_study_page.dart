import 'package:flutter/material.dart';
import 'dart:ui'; // Pour l'effet BackdropFilter (verre flou)
import '../../models/courses_study/courses_study_model.dart';


class CourseStudyPage extends StatefulWidget {
  final String chapterTitle;
  final String chapterSubtitle;
  final List<CoursePageContent> pages;

  const CourseStudyPage({
    super.key,
    required this.chapterTitle,
    required this.chapterSubtitle,
    required this.pages,
  });

  @override
  State<CourseStudyPage> createState() => _CourseStudyPageState();
}

class _CourseStudyPageState extends State<CourseStudyPage> {
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < widget.pages.length - 1) {
      setState(() => _currentPage++);
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(color: const Color(0xFF0D0D2B)),
          Opacity(
            opacity: 0.90,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            children: [
              _buildTopNavBar(h, w),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.03,
                    vertical: h * 0.01,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildChapterHeader(h, w),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                              child: Container(
                                height: 1.5,
                                color: Colors.blue.withValues(alpha: 0.5),
                              ),
                            ),
                            SizedBox(height: h * 0.02),
                            Expanded(
                              child: _buildPageContent(h, w),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              _buildBottomNavBar(h, w),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopNavBar(double h, double w) {
    return Container(
      height: h * 0.08,
      padding: EdgeInsets.symmetric(horizontal: w * 0.02),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        border: Border(
          bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/icone_dash.png",
            height: h * 0.12,
            width: w * 0.12,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.school,
              color: Colors.blue,
              size: 40,
            ),
          ),
          SizedBox(width: w * 0.02),
          Container(
            width: 1,
            height: h * 0.04,
            color: Colors.white24,
          ),
          SizedBox(width: w * 0.02),
          _buildNavButton(Icons.home_outlined, "Home", h),
          SizedBox(width: w * 0.02),
          _buildNavButton(Icons.emoji_events_outlined, "Leaderboard", h),
          SizedBox(width: w * 0.02),
          _buildNavButton(Icons.folder_outlined, "Files", h),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.015,
              vertical: h * 0.008,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white24),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: h * 0.025,
                  backgroundColor: Colors.blue,
                  child: Text(
                    "H",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: h * 0.02,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  "Hamid_09",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: h * 0.018,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(IconData icon, String label, double h) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: h * 0.025),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: h * 0.017),
        ),
      ],
    );
  }

  Widget _buildChapterHeader(double h, double w) {
    return Padding(
      padding: EdgeInsets.all(h * 0.02),
      child: Row(
        children: [
          Container(
            width: h * 0.07,
            height: h * 0.07,
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.4)),
            ),
            child: Icon(
              Icons.smart_toy_outlined,
              color: Colors.blue,
              size: h * 0.04,
            ),
          ),
          SizedBox(width: w * 0.015),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.chapterTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: h * 0.025,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.chapterSubtitle,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: h * 0.017,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

 Widget _buildPageContent(double h, double w) {
  final page = widget.pages[_currentPage];
  return SingleChildScrollView(
    padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.01),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          page.title, // ← ici on utilise la propriété de l'objet
          style: TextStyle(
            color: Colors.white,
            fontSize: h * 0.038,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: h * 0.025),
        Text(
          page.content, // ← idem
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: h * 0.020,
            height: 1.6,
          ),
        ),
        if (page.imagePath != null) ...[
          SizedBox(height: h * 0.03),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              page.imagePath!,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
        ],
        if (page.bulletPoints != null && page.bulletPoints!.isNotEmpty)
          ...page.bulletPoints!.map<Widget>((point) => Padding(
                padding: EdgeInsets.only(bottom: h * 0.012),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: h * 0.006),
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        point,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: h * 0.019,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        SizedBox(height: h * 0.04),
      ],
    ),
  );
}

  Widget _buildBottomNavBar(double h, double w) {
    final isFirstPage = _currentPage == 0;
    final isLastPage = _currentPage == widget.pages.length - 1;

    return Container(
      height: h * 0.08,
      padding: EdgeInsets.symmetric(horizontal: w * 0.03),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: isFirstPage ? null : _prevPage,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: w * 0.015, vertical: h * 0.015),
              decoration: BoxDecoration(
                color: isFirstPage
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: isFirstPage ? Colors.white12 : Colors.white30),
              ),
              child: Row(
                children: [
                  Icon(Icons.chevron_left, color: isFirstPage ? Colors.white24 : Colors.white, size: h * 0.03),
                  SizedBox(width: 4),
                  Icon(Icons.menu, color: isFirstPage ? Colors.white24 : Colors.white, size: h * 0.025),
                ],
              ),
            ),
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: w * 0.025, vertical: h * 0.012),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white24),
            ),
            child: Text(
              "${_currentPage + 1}/${widget.pages.length}",
              style: TextStyle(color: Colors.white, fontSize: h * 0.020, fontWeight: FontWeight.w500),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: isLastPage ? null : _nextPage,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: w * 0.025, vertical: h * 0.015),
              decoration: BoxDecoration(
                color: isLastPage ? Colors.blue.withValues(alpha: 0.2) : Colors.blue,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: isLastPage ? Colors.blue.withValues(alpha: 0.3) : Colors.blue),
              ),
              child: Row(
                children: [
                  Text(
                    isLastPage ? "Terminé ✓" : "→ Suivant",
                    style: TextStyle(color: Colors.white, fontSize: h * 0.020, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}