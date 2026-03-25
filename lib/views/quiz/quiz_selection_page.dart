// views/quiz/quiz_selection_page.dart
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_project_1/controllers/quiz/quiz_controller.dart';
import 'package:flutter_project_1/views/quiz/quiz_page_content.dart';
import '../dashboard/dashboard_page.dart';
import '../auth/login_page.dart';
import '../leaderboard/leaderboard_page.dart';
import '../files/files_page.dart';
import '../../views/quiz/algo2_quiz_selection_page.dart';

class QuizSelectionPage extends StatefulWidget {
  final bool isAlgo2;

  const QuizSelectionPage({
    super.key,
    this.isAlgo2 = false, // valeur par défaut
  });

  @override
  State<QuizSelectionPage> createState() => _QuizSelectionPageState();
}

class _QuizSelectionPageState extends State<QuizSelectionPage> {
  int _selectedIndex = 1;
  int _selectedAlgo = 1;
  List<String> _selectedChapters = [];
  int _selectedIntensity = 10;
  int _currentStep = 1;

  // Liste des chapitres disponibles pour Algo 1
  final List<Map<String, String>> _chapters = [
  {"id": "Chapitre 01", "title": "Basics", "icon": "assets/images/icons_algo1/basics_icone.png"},
  {"id": "Chapitre 02", "title": "Conditions", "icon": "assets/images/icons_algo1/si_sinon_icon.png"},
  {"id": "Chapitre 03", "title": "Loops", "icon": "assets/images/icons_algo1/loops_icone.png"},
  {"id": "Chapitre 04", "title": "Data Structures - Vectors and Matrices", "icon": "assets/images/icons_algo1/vectors_matris_icon.png"},
  {"id": "Chapitre 05", "title": "Subprograms (Functions and Procedures)", "icon": "assets/images/icons_algo1/fonction_procedure_icone.png"},

];

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Fond couleur sombre
          Container(color: const Color(0xFF0D0D2B)),
          // Image de fond avec opacité
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
          // Contenu principal
          Row(
            children: [
              _buildSidebar(h, w),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      margin: EdgeInsets.all(h * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.02),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.15),
                          width: 1.5,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(h * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader(h),
                            SizedBox(height: h * 0.02),
                            _buildFilters(h),
                            SizedBox(height: h * 0.02),
                            _buildProgressSteps(h, w),
                            SizedBox(height: h * 0.03),
                            Expanded(
                              child: _currentStep == 1
                                  ? _buildChapterSelection(h, w)
                                  : _currentStep == 2
                                      ? _buildIntensitySelection(h, w)
                                      : _buildReviewSection(h, w),
                            ),
                            _buildNavigationButtons(h, w),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              _buildRightPanel(h, w),
            ],
          ),
        ],
      ),
    );
  }

  // ========== SIDEBAR ==========
  Widget _buildSidebar(double h, double w) {
    final items = [
      {"icon": Icons.menu_book, "label": "Courses"},
      {"icon": Icons.quiz, "label": "Quiz"},
      {"icon": Icons.emoji_events, "label": "Leaderboard"},
      {"icon": Icons.folder, "label": "Files"},
    ];

    return Container(
      width: w * 0.07,
      color: const Color.fromARGB(66, 33, 32, 32),
      child: Column(
        children: [
          SizedBox(height: h * 0.02),
          Image.asset(
            "assets/images/icone_dash.png",
            width: h * 0.15,
            height: h * 0.15,
            errorBuilder: (_, __, ___) => Icon(
              Icons.school,
              color: Colors.blue,
              size: h * 0.08,
            ),
          ),
          SizedBox(height: h * 0.04),
          ...items.asMap().entries.map(
            (entry) => GestureDetector(
              onTap: () {
                setState(() => _selectedIndex = entry.key);
                _navigateToPage(entry.key);
              },
              child: _buildSidebarItem(
                icon: entry.value["icon"] as IconData,
                label: entry.value["label"] as String,
                h: h,
                isActive: _selectedIndex == entry.key,
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            ),
            child: _buildSidebarItem(
              icon: Icons.logout,
              label: "Logout",
              h: h,
              isLogout: true,
            ),
          ),
          SizedBox(height: h * 0.02),
        ],
      ),
    );
  }

  void _navigateToPage(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const LeaderboardPage()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const FilesPage()),
      );
    }
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String label,
    required double h,
    bool isLogout = false,
    bool isActive = false,
  }) {
    return Row(
      children: [
        Container(
          width: 4,
          height: h * 0.08,
          decoration: BoxDecoration(
            color: isActive ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: h * 0.02),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: isActive
                      ? Colors.blue
                      : (isLogout ? Colors.red : Colors.white70),
                  size: h * 0.06,
                ),
                SizedBox(height: h * 0.005),
                Text(
                  label,
                  style: TextStyle(
                    color: isActive
                        ? Colors.blue
                        : (isLogout ? Colors.red : Colors.white70),
                    fontSize: h * 0.020,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ========== HEADER ==========
  Widget _buildHeader(double h) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Prepare your quiz",
          style: TextStyle(
            fontSize: h * 0.04,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: h * 0.005),
        Text(
          "Select chapters and quiz intensity to begin",
          style: TextStyle(fontSize: h * 0.016, color: Colors.white60),
        ),
      ],
    );
  }

  // ========== FILTRES ALGO 1 / ALGO 2 ==========
  Widget _buildFilters(double h) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => setState(() => _selectedAlgo = 1),
          child: _filterChip("Algo 1", h, selected: _selectedAlgo == 1),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () {
          // Naviguer vers Algo2QuizSelectionPage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const Algo2QuizSelectionPage(),
            ),
          );
        },

          child: _filterChip("Algo 2 (En construction)", h, selected: _selectedAlgo == 2),
        ),
      ],
    );
  }

  Widget _filterChip(String label, double h, {bool selected = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: h * 0.008),
      decoration: BoxDecoration(
        color: selected ? Colors.blue : Colors.white12,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: selected ? Colors.blue : Colors.white24),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: h * 0.015,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  // ========== PROGRESS STEPS ==========
  Widget _buildProgressSteps(double h, double w) {
    return Row(
      children: [
        _buildStep(
          h,
          stepNumber: 1,
          label: "Chapters",
          isActive: _currentStep == 1,
          isCompleted: _currentStep > 1,
        ),
        Expanded(
          child: Container(
            height: 2,
            color: _currentStep > 1 ? Colors.blue : Colors.white24,
          ),
        ),
        _buildStep(
          h,
          stepNumber: 2,
          label: "Intensity",
          isActive: _currentStep == 2,
          isCompleted: _currentStep > 2,
        ),
        Expanded(
          child: Container(
            height: 2,
            color: _currentStep > 2 ? Colors.blue : Colors.white24,
          ),
        ),
        _buildStep(
          h,
          stepNumber: 3,
          label: "Review",
          isActive: _currentStep == 3,
          isCompleted: _currentStep > 3,
        ),
      ],
    );
  }

  Widget _buildStep(double h, {
    required int stepNumber,
    required String label,
    required bool isActive,
    required bool isCompleted,
  }) {
    return Column(
      children: [
        Container(
          width: h * 0.05,
          height: h * 0.05,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? Colors.blue
                : isCompleted
                    ? Colors.green
                    : Colors.white24,
            border: Border.all(
              color: isActive ? Colors.blue : Colors.white24,
              width: 2,
            ),
          ),
          child: Center(
            child: isCompleted
                ? Icon(Icons.check, color: Colors.white, size: h * 0.025)
                : Text(
                    stepNumber.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: h * 0.022,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        SizedBox(height: h * 0.008),
        Text(
          label,
          style: TextStyle(
            color: isActive || isCompleted ? Colors.blue : Colors.white54,
            fontSize: h * 0.014,
          ),
        ),
      ],
    );
  }

  // ========== CHAPTER SELECTION (Style Dashboard) ==========
  Widget _buildChapterSelection(double h, double w) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select chapters",
          style: TextStyle(
            color: Colors.white,
            fontSize: h * 0.022,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: h * 0.02),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 60,
              mainAxisSpacing: 25,
              childAspectRatio: 3.5,
            ),
            itemCount: _chapters.length,
            itemBuilder: (context, index) {
              final chapter = _chapters[index];
              final isSelected = _selectedChapters.contains(chapter["id"]);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedChapters.remove(chapter["id"]);
                    } else {
                      _selectedChapters.add(chapter["id"]!);
                    }
                  });
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(13),
                    topRight: Radius.circular(13),
                    bottomLeft: Radius.circular(27),
                    bottomRight: Radius.circular(27),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: EdgeInsets.only(
                        top: h * 0.005,
                        left: h * 0.02,
                        right: h * 0.02,
                        bottom: h * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color.fromARGB(255,33, 150, 243).withValues(alpha: 0.3)
                            : Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.white24,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    chapter["id"]!,
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: h * 0.025,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: h * 0.005),
                                  Text(
                                    chapter["title"]!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: h * 0.02,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: h * 0.010),
                          // Image avec checkbox
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Image.asset(
                                  chapter["icon"]!,
                                  width: h * 0.08,
                                  height: h * 0.08,
                                  errorBuilder: (context, error, stackTrace) => Icon(
                                    Icons.image_not_supported,
                                    color: Colors.white38,
                                    size: h * 0.04,
                                  ),
                                ),
                              ),
                              // Checkbox en haut à droite de l'image
                              Container(
                                width: h * 0.025,
                                height: h * 0.025,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected ? Colors.blue : Colors.white24,
                                  border: Border.all(
                                    color: isSelected ? Colors.blue : Colors.white54,
                                    width: 2,
                                  ),
                                ),
                                child: isSelected
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: h * 0.015,
                                      )
                                    : null,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
// Ajoutez les icons depuis dashboard
String _getChapterIcon(String chapterId) {
  switch (chapterId) {
    case "Chapitre 01":
      return "assets/images/icons_algo1/basics_icone.png";
    case "Chapitre 02":
      return "assets/images/icons_algo1/si_sinon_icon.png";
    case "Chapitre 03":
      return "assets/images/icons_algo1/loops_icone.png";
    case "Chapitre 04":
      return "assets/images/icons_algo1/vectors_matris_icon.png";
    case "Chapitre 05":
      return "assets/images/icons_algo1/fonction_procedure_icone.png";
    default:
      return "assets/images/icons_algo1/basics_icone.png";
  }
}
  // ========== INTENSITY SELECTION ==========
  Widget _buildIntensitySelection(double h, double w) {
    final intensities = [10, 15, 20, 30];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quiz difficulty level",
          style: TextStyle(
            color: Colors.white,
            fontSize: h * 0.022,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: h * 0.02),
        Wrap(
          spacing: 16,
          children: intensities.map((intensity) {
            final isSelected = _selectedIntensity == intensity;
            return GestureDetector(
              onTap: () => setState(() => _selectedIntensity = intensity),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.03,
                  vertical: h * 0.015,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.blue
                      : Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.white24,
                  ),
                ),
                child: Text(
                  "$intensity ●",
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.white70,
                    fontSize: h * 0.020,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: h * 0.03),
        Container(
          padding: EdgeInsets.all(h * 0.02),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What does difficulty level mean?",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: h * 0.018,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: h * 0.01),
              Text(
                "The difficulty level determines how many questions you'll answer from each selected chapter:\n\n"
                "• 10 ● : Basic questions - Good for learning\n"
                "• 15 ● : Intermediate - Mix of difficulty\n"
                "• 20 ● : Advanced - Challenging questions\n"
                "• 30 ● : Expert - Maximum difficulty",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: h * 0.014,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ========== REVIEW SECTION ==========
  Widget _buildReviewSection(double h, double w) {
    final totalQuestions = _selectedChapters.length * _selectedIntensity;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(h * 0.02),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: h * 0.03),
                    SizedBox(width: 12),
                    Text(
                      "Quiz Configuration",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: h * 0.022,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: h * 0.02),
                _buildReviewRow(
                  h,
                  "Selected Chapters",
                  "${_selectedChapters.length}",
                ),
                SizedBox(height: h * 0.01),
                ..._selectedChapters.map((chapterId) {
                  final chapter = _chapters.firstWhere(
                    (c) => c["id"] == chapterId,
                    orElse: () => {"title": "Unknown", "icon": "❓"},
                  );
                  return Padding(
                    padding: EdgeInsets.only(left: w * 0.03, bottom: h * 0.008),
                    child: Row(
                      children: [
                        Text(
                          "•",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: h * 0.020,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          chapter["title"]!,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: h * 0.016,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                SizedBox(height: h * 0.02),
                _buildReviewRow(
                  h,
                  "Difficulty Level",
                  "$_selectedIntensity ●",
                ),
                SizedBox(height: h * 0.02),
                _buildReviewRow(
                  h,
                  "Total Questions",
                  "$totalQuestions",
                ),
                SizedBox(height: h * 0.02),
                Container(
                  padding: EdgeInsets.all(h * 0.015),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.withValues(alpha: 0.5)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.green, size: h * 0.022),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "You're ready to start! Click 'Start Quiz' to begin.",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: h * 0.014,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewRow(double h, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white54,
            fontSize: h * 0.016,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.blue,
            fontSize: h * 0.016,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ========== NAVIGATION BUTTONS ==========
  Widget _buildNavigationButtons(double h, double w) {
    return Padding(
      padding: EdgeInsets.only(top: h * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Bouton Retour
          if (_currentStep > 1)
            GestureDetector(
              onTap: () => setState(() => _currentStep--),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.02,
                  vertical: h * 0.015,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white30),
                ),
                child: Row(
                  children: [
                    Icon(Icons.chevron_left, color: Colors.white, size: h * 0.02),
                    Text(
                      "Back",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: h * 0.018,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            const SizedBox(width: 80),

          // Bouton Suivant / Démarrer
          if (_currentStep < 3)
            GestureDetector(
              onTap: () {
                if (_currentStep == 1 && _selectedChapters.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Please select at least one chapter"),
                      backgroundColor: Colors.orange.shade700,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  return;
                }
                setState(() => _currentStep++);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.03,
                  vertical: h * 0.015,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: h * 0.018,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.chevron_right, color: Colors.white, size: h * 0.02),
                  ],
                ),
              ),
            )
          else
            GestureDetector(
              onTap: () {
                final controller = QuizController(
                  selectedChapters: _selectedChapters,
                  intensity: _selectedIntensity,
                );
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizPageContent(
                      controller: controller,
                    ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.04,
                  vertical: h * 0.015,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green, Colors.green.shade700],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      "Start Quiz",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: h * 0.018,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.play_arrow, color: Colors.white, size: h * 0.022),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ========== RIGHT PANEL ==========
  Widget _buildRightPanel(double h, double w) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: w * 0.22,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            border: Border(
              left: BorderSide(color: Colors.blue.withValues(alpha: 0.2)),
            ),
          ),
          padding: EdgeInsets.all(h * 0.025),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue, size: h * 0.022),
                  SizedBox(width: 8),
                  Text(
                    "Quiz Info",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: h * 0.020,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: h * 0.02),
              _buildInfoCard(
                h,
                icon: Icons.school,
                label: "Total Chapters",
                value: "${_chapters.length}",
                color: Colors.blue,
              ),
              SizedBox(height: h * 0.015),
              _buildInfoCard(
                h,
                icon: Icons.check_circle_outline,
                label: "Selected",
                value: "${_selectedChapters.length}",
                color: Colors.green,
              ),
              SizedBox(height: h * 0.015),
              _buildInfoCard(
                h,
                icon: Icons.assignment,
                label: "Questions",
                value: "${_selectedChapters.length * _selectedIntensity}",
                color: Colors.purple,
              ),
              SizedBox(height: h * 0.02),
              Container(
                height: 1,
                color: Colors.white12,
              ),
              SizedBox(height: h * 0.02),
              Text(
                "Tips:",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: h * 0.016,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: h * 0.01),
              Text(
                "• Mix different chapters\n"
                "• Higher difficulty = more challenging\n"
                "• Review before starting\n"
                "• Take your time answering",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: h * 0.013,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(double h, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(h * 0.015),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: h * 0.028),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: h * 0.013,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontSize: h * 0.020,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
