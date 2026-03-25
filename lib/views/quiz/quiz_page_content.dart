// views/quiz/quiz_page_content.dart
import 'package:flutter/material.dart';
import 'dart:ui';
import '../../controllers/quiz/quiz_controller.dart';
import '../../models/quiz/quiz_model.dart';
import '../dashboard/dashboard_page.dart';
import '../../views/auth/login_page.dart';
import '../files/files_page.dart';
import '../leaderboard/leaderboard_page.dart';
import 'quiz_selection_page.dart';

class QuizPageContent extends StatefulWidget {
  final QuizController controller;

  const QuizPageContent({super.key, required this.controller});

  @override
  State<QuizPageContent> createState() => _QuizPageContentState();
}

class _QuizPageContentState extends State<QuizPageContent> {
  bool? _answerChecked;
  List<String> _currentOrder = [];
  bool _quizCompleted = false;

  @override
  void initState() {
    super.initState();
    _initOrdering();
  }

  void _initOrdering() {
    final q = widget.controller.currentQuestion;
    if (q.type == QuestionType.ordering && q.codeLines != null) {
      _currentOrder = List.from(q.codeLines!);
    }
  }

  void _checkAnswer() {
    final q = widget.controller.currentQuestion;
    final isCorrect = widget.controller.checkAnswer(q.id);
    setState(() {
      _answerChecked = isCorrect;
    });
  }

  void _nextQuestion() {
    if (widget.controller.isLastQuestion) {
      if (widget.controller.isLastQuiz) {
        setState(() => _quizCompleted = true);
      } else {
        widget.controller.nextQuiz();
        setState(() {
          _answerChecked = null;
          _currentOrder = [];
          _initOrdering();
        });
      }
    } else {
      widget.controller.nextQuestion();
      setState(() {
        _answerChecked = null;
        _currentOrder = [];
        _initOrdering();
      });
    }
  }

  void _prevQuestion() {
    widget.controller.prevQuestion();
    setState(() {
      _answerChecked = null;
      _currentOrder = [];
      _initOrdering();
    });
  }

  void _resetQuiz() {
    widget.controller.resetSession();
    setState(() {
      _answerChecked = null;
      _quizCompleted = false;
      _currentOrder = [];
      _initOrdering();
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    if (_quizCompleted) {
      return _buildCompletionScreen(h, w);
    }

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
                  child: Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                            child: Container(
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
                                  children: [
                                    _buildHeader(h),
                                    SizedBox(height: h * 0.02),
                                    _buildProgressBar(h, w),
                                    SizedBox(height: h * 0.02),
                                    Expanded(
                                      child: _buildQuestionContent(h, w),
                                    ),
                                    _buildBottomNav(h, w),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: w * 0.02),
                      _buildRightPanel(h, w),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ========== TOP NAV BAR (Style course_study_page) ==========
  Widget _buildTopNavBar(double h, double w) {
    return Container(
      height: h * 0.11,
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
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.school, color: Colors.blue, size: 40),
          ),
          SizedBox(width: w * 0.02),
          Container(width: 1, height: h * 0.05, color: Colors.white24),
          SizedBox(width: w * 0.02),
          GestureDetector(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const DashboardPage()),
            ),
            child: _buildNavButton(Icons.home_outlined, "Home", h),
          ),
          SizedBox(width: w * 0.02),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LeaderboardPage()),
              );
            },
            child: _buildNavButton(
              Icons.emoji_events_outlined,
              "Leaderboard",
              h,
            ),
          ),
          SizedBox(width: w * 0.02),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FilesPage()),
              );
            },
            child: _buildNavButton(Icons.folder_outlined, "Files", h),
          ),
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
                  radius: h * 0.030,
                  backgroundColor: Colors.blue,
                  child: Text(
                    "H",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: h * 0.025,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  "Hamid_09",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: h * 0.020,
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
        Icon(icon, color: Colors.white70, size: h * 0.035),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: h * 0.020),
        ),
      ],
    );
  }

  // ========== COMPLETION SCREEN ==========
  Widget _buildCompletionScreen(double h, double w) {
    final totalScore = widget.controller.getTotalScore();
    final totalQuestions = widget.controller.session.totalPossibleScore;
    final percentage = widget.controller.getPercentage();

    String message;
    IconData icon;
    Color color;

    if (percentage >= 80) {
      message = "Excellent! You're a pro! 🎉";
      icon = Icons.emoji_events;
      color = const Color(0xFFFFD700);
    } else if (percentage >= 60) {
      message = "Good job! Keep going! 👍";
      icon = Icons.thumb_up;
      color = Colors.green;
    } else if (percentage >= 40) {
      message = "Not bad! Review and try again! 📚";
      icon = Icons.school;
      color = Colors.orange;
    } else {
      message = "Keep practicing! You'll get there! 💪";
      icon = Icons.fitness_center;
      color = Colors.red;
    }

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
          Center(
            child: SingleChildScrollView(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: w * 0.45,
                    padding: EdgeInsets.all(h * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: const Duration(milliseconds: 800),
                          builder: (context, value, child) {
                            return Transform.scale(
                              scale: value,
                              child: Container(
                                padding: EdgeInsets.all(h * 0.02),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: color.withValues(alpha: 0.2),
                                  border: Border.all(color: color, width: 3),
                                ),
                                child: Icon(icon, size: h * 0.08, color: color),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: h * 0.03),
                        Text(
                          "Quiz Completed!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: h * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: h * 0.02),
                        Text(
                          message,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: h * 0.018,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: h * 0.03),
                        SizedBox(
                          width: h * 0.15,
                          height: h * 0.15,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: h * 0.15,
                                height: h * 0.15,
                                child: CircularProgressIndicator(
                                  value: totalQuestions > 0
                                      ? totalScore / totalQuestions
                                      : 0,
                                  strokeWidth: h * 0.012,
                                  backgroundColor: Colors.white24,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    color,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "$totalScore",
                                    style: TextStyle(
                                      color: color,
                                      fontSize: h * 0.045,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "/ $totalQuestions",
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: h * 0.016,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: h * 0.02),
                        Text(
                          "$percentage%",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: h * 0.028,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: h * 0.04),
                        Container(
                          height: h * 0.008,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: FractionallySizedBox(
                            widthFactor: percentage / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: h * 0.04),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const QuizSelectionPage(),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white24,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: w * 0.02,
                                  vertical: h * 0.015,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                    size: h * 0.02,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "New Quiz",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: h * 0.016,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: _resetQuiz,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: w * 0.02,
                                  vertical: h * 0.015,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.replay,
                                    color: Colors.white,
                                    size: h * 0.02,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Try Again",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: h * 0.016,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: h * 0.02),
                        TextButton(
                          onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DashboardPage(),
                            ),
                          ),
                          child: Text(
                            "Back to Dashboard",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: h * 0.014,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ========== HEADER ==========
  Widget _buildHeader(double h) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quiz in Progress",
          style: TextStyle(
            fontSize: h * 0.04,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: h * 0.005),
        Text(
          "Chapter: ${widget.controller.currentQuiz.chapter}",
          style: TextStyle(fontSize: h * 0.016, color: Colors.white60),
        ),
      ],
    );
  }

  // ========== PROGRESS BAR ==========
  Widget _buildProgressBar(double h, double w) {
    final currentQuizProgress =
        (widget.controller.currentQuestionIndex + 1) /
        widget.controller.totalQuestionsInCurrentQuiz;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Course progression",
              style: TextStyle(color: Colors.white70, fontSize: h * 0.018),
            ),
            Text(
              "${(currentQuizProgress * 100).toInt()}%",
              style: TextStyle(
                color: Colors.white,
                fontSize: h * 0.018,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: h * 0.01),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: currentQuizProgress,
            backgroundColor: Colors.white12,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            minHeight: h * 0.012,
          ),
        ),
      ],
    );
  }

  // ========== QUESTION CONTENT ==========
  Widget _buildQuestionContent(double h, double w) {
    final question = widget.controller.currentQuestion;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(h * 0.03),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: h * 0.02,
                  vertical: h * 0.008,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Question ${widget.controller.currentQuestionIndex + 1} of ${widget.controller.totalQuestionsInCurrentQuiz}",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: h * 0.016,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),
              Text(
                question.enonce,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: h * 0.022,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
              SizedBox(height: h * 0.03),
              Expanded(
                child: question.type == QuestionType.multipleChoice
                    ? _buildMultipleChoice(h, question)
                    : _buildOrdering(h, question),
              ),
              SizedBox(height: h * 0.02),
              _buildVerifyButton(h, question),
              if (_answerChecked != null) _buildFeedback(h),
            ],
          ),
        ),
      ),
    );
  }

  // ========== MULTIPLE CHOICE ==========
  Widget _buildMultipleChoice(double h, Question question) {
    final choices = [
      {"key": "A", "label": question.reponseA},
      {"key": "B", "label": question.reponseB},
      {"key": "C", "label": question.reponseC},
      {"key": "D", "label": question.reponseD},
    ];

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 3.5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: choices.map((choice) {
        final isSelected =
            widget.controller.currentQuiz.userAnswers[question.id] ==
            choice["key"];

        Color borderColor = Colors.white24;
        Color bgColor = Colors.white.withValues(alpha: 0.08);

        if (_answerChecked != null && isSelected) {
          borderColor = _answerChecked! ? Colors.green : Colors.red;
          bgColor = _answerChecked!
              ? Colors.green.withValues(alpha: 0.2)
              : Colors.red.withValues(alpha: 0.2);
        } else if (isSelected) {
          borderColor = Colors.blue;
          bgColor = Colors.blue.withValues(alpha: 0.2);
        }

        return GestureDetector(
          onTap: _answerChecked != null
              ? null
              : () => setState(() {
                  widget.controller.answerMultipleChoice(
                    question.id,
                    choice["key"]!,
                  );
                }),
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor, width: 1.5),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: h * 0.01),
                child: Text(
                  choice["label"]!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: h * 0.016,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ========== ORDERING ==========
  Widget _buildOrdering(double h, Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: h * 0.02,
            vertical: h * 0.01,
          ),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.drag_handle, color: Colors.blue, size: h * 0.02),
              SizedBox(width: 8),
              Text(
                "Drag and drop to order the steps",
                style: TextStyle(color: Colors.blue, fontSize: h * 0.014),
              ),
            ],
          ),
        ),
        SizedBox(height: h * 0.015),
        Expanded(
          child: ReorderableListView.builder(
            shrinkWrap: true,
            itemCount: _currentOrder.length,
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) newIndex--;
                final item = _currentOrder.removeAt(oldIndex);
                _currentOrder.insert(newIndex, item);
                widget.controller.setOrdering(question.id, _currentOrder);
              });
            },
            itemBuilder: (context, index) {
              return Container(
                key: ValueKey(_currentOrder[index]),
                margin: EdgeInsets.only(bottom: h * 0.01),
                padding: EdgeInsets.symmetric(
                  horizontal: h * 0.02,
                  vertical: h * 0.012,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.1),
                      Colors.white.withValues(alpha: 0.05),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white24),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.drag_handle,
                      color: Colors.white54,
                      size: h * 0.025,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _currentOrder[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: h * 0.016,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    Container(
                      width: h * 0.035,
                      height: h * 0.035,
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: h * 0.014,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ========== VERIFY BUTTON ==========
  Widget _buildVerifyButton(double h, Question question) {
    final hasAnswer = question.type == QuestionType.multipleChoice
        ? widget.controller.currentQuiz.userAnswers.containsKey(question.id)
        : widget.controller.currentQuiz.userOrderings.containsKey(question.id);

    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: ElevatedButton(
          onPressed: (_answerChecked != null || !hasAnswer)
              ? null
              : _checkAnswer,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.withValues(alpha: 0.8),
            disabledBackgroundColor: Colors.white12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: h * 0.04,
              vertical: h * 0.015,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.white,
                size: h * 0.022,
              ),
              SizedBox(width: 8),
              Text(
                "Check Answer",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: h * 0.018,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ========== FEEDBACK ==========
  Widget _buildFeedback(double h) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 300),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(top: h * 0.015),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: h * 0.03,
              vertical: h * 0.01,
            ),
            decoration: BoxDecoration(
              color: _answerChecked!
                  ? Colors.green.withValues(alpha: 0.2)
                  : Colors.red.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _answerChecked! ? Colors.green : Colors.red,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _answerChecked! ? Icons.check_circle : Icons.cancel,
                  color: _answerChecked! ? Colors.green : Colors.red,
                  size: h * 0.022,
                ),
                SizedBox(width: 8),
                Text(
                  _answerChecked! ? "✓ Correct!" : "✗ Incorrect!",
                  style: TextStyle(
                    color: _answerChecked! ? Colors.green : Colors.red,
                    fontSize: h * 0.018,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ========== BOTTOM NAVIGATION ==========
  Widget _buildBottomNav(double h, double w) {
    return Padding(
      padding: EdgeInsets.only(top: h * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: widget.controller.isFirstQuestion ? null : _prevQuestion,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.02,
                vertical: h * 0.015,
              ),
              decoration: BoxDecoration(
                color: widget.controller.isFirstQuestion
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: widget.controller.isFirstQuestion
                      ? Colors.white12
                      : Colors.white30,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.chevron_left,
                    color: widget.controller.isFirstQuestion
                        ? Colors.white24
                        : Colors.white,
                    size: h * 0.02,
                  ),
                  Text(
                    "Prev",
                    style: TextStyle(
                      color: widget.controller.isFirstQuestion
                          ? Colors.white24
                          : Colors.white,
                      fontSize: h * 0.016,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.02,
              vertical: h * 0.008,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "${widget.controller.currentQuestionIndex + 1} / ${widget.controller.totalQuestionsInCurrentQuiz}",
              style: TextStyle(
                color: Colors.white70,
                fontSize: h * 0.016,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            onTap: _answerChecked == null ? null : _nextQuestion,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.02,
                vertical: h * 0.015,
              ),
              decoration: BoxDecoration(
                gradient: _answerChecked == null
                    ? null
                    : (widget.controller.isLastQuestion &&
                              widget.controller.isLastQuiz
                          ? const LinearGradient(
                              colors: [Colors.green, Color(0xFF00C853)],
                            )
                          : const LinearGradient(
                              colors: [Colors.blue, Color(0xFF2196F3)],
                            )),
                color: _answerChecked == null
                    ? Colors.white.withValues(alpha: 0.05)
                    : null,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _answerChecked == null
                      ? Colors.white12
                      : Colors.transparent,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    (widget.controller.isLastQuestion &&
                            widget.controller.isLastQuiz)
                        ? "Finish"
                        : "Next",
                    style: TextStyle(
                      color: _answerChecked == null
                          ? Colors.white24
                          : Colors.white,
                      fontSize: h * 0.016,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    (widget.controller.isLastQuestion &&
                            widget.controller.isLastQuiz)
                        ? Icons.check_circle
                        : Icons.chevron_right,
                    color: _answerChecked == null
                        ? Colors.white24
                        : Colors.white,
                    size: h * 0.018,
                  ),
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
          width: w * 0.18,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
              width: 1.5,
            ),
          ),
          padding: EdgeInsets.all(h * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.question_answer,
                    color: Colors.blue,
                    size: h * 0.022,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Questions",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: h * 0.022,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: h * 0.02),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.controller.totalQuestionsInCurrentQuiz,
                  itemBuilder: (context, index) {
                    final q = widget.controller.currentQuiz.questions[index];
                    final status = widget.controller.getQuestionStatus(q.id);
                    final isCurrent =
                        widget.controller.currentQuestionIndex == index;

                    Color bgColor;
                    if (status == true) {
                      bgColor = Colors.green;
                    } else if (status == false) {
                      bgColor = Colors.red;
                    } else if (isCurrent) {
                      bgColor = Colors.blue;
                    } else {
                      bgColor = Colors.white.withValues(alpha: 0.1);
                    }

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.controller.currentQuiz.currentQuestionIndex =
                              index;
                          _answerChecked = null;
                          _initOrdering();
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: h * 0.01),
                        padding: EdgeInsets.symmetric(vertical: h * 0.012),
                        decoration: BoxDecoration(
                          color: bgColor.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isCurrent
                                ? Colors.white
                                : (status == true
                                      ? Colors.green.withValues(alpha: 0.5)
                                      : status == false
                                      ? Colors.red.withValues(alpha: 0.5)
                                      : Colors.white24),
                            width: isCurrent ? 1.5 : 1,
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (status == true)
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: h * 0.016,
                                ),
                              if (status == false)
                                Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                  size: h * 0.016,
                                ),
                              if (status == null)
                                Icon(
                                  Icons.help_outline,
                                  color: Colors.white54,
                                  size: h * 0.016,
                                ),
                              SizedBox(width: 6),
                              Text(
                                "Question ${index + 1}",
                                style: TextStyle(
                                  color: isCurrent
                                      ? Colors.white
                                      : status == true
                                      ? Colors.green
                                      : status == false
                                      ? Colors.red
                                      : Colors.white70,
                                  fontSize: h * 0.014,
                                  fontWeight: isCurrent
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: h * 0.01),
              Container(
                padding: EdgeInsets.all(h * 0.015),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withValues(alpha: 0.3),
                      Colors.purple.withValues(alpha: 0.3),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.withValues(alpha: 0.5)),
                ),
                child: Column(
                  children: [
                    Text(
                      "Session Score",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: h * 0.012,
                      ),
                    ),
                    Text(
                      "${widget.controller.getTotalScore()} / ${widget.controller.session.totalPossibleScore}",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: h * 0.028,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: h * 0.005),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: widget.controller.session.totalPossibleScore > 0
                            ? widget.controller.getTotalScore() /
                                  widget.controller.session.totalPossibleScore
                            : 0,
                        minHeight: h * 0.004,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.blue,
                        ),
                      ),
                    ),
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
