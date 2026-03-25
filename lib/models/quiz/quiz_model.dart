// models/quiz/quiz_model.dart

enum QuestionType { multipleChoice, ordering }

class Question {
  final String id;
  final String enonce;
  final String reponseA;
  final String reponseB;
  final String reponseC;
  final String reponseD;
  final String bonneReponse; // "A", "B", "C", "D" pour multipleChoice
  // "Initialization|Condition|Body|Increment" pour ordering
  final QuestionType type;
  final List<String>? codeLines; // pour type ordering uniquement

  Question({
    required this.id,
    required this.enonce,
    required this.reponseA,
    required this.reponseB,
    required this.reponseC,
    required this.reponseD,
    required this.bonneReponse,
    required this.type,
    this.codeLines,
  });

  /// Copie la question avec certains paramètres modifiés
  Question copyWith({
    String? id,
    String? enonce,
    String? reponseA,
    String? reponseB,
    String? reponseC,
    String? reponseD,
    String? bonneReponse,
    QuestionType? type,
    List<String>? codeLines,
  }) {
    return Question(
      id: id ?? this.id,
      enonce: enonce ?? this.enonce,
      reponseA: reponseA ?? this.reponseA,
      reponseB: reponseB ?? this.reponseB,
      reponseC: reponseC ?? this.reponseC,
      reponseD: reponseD ?? this.reponseD,
      bonneReponse: bonneReponse ?? this.bonneReponse,
      type: type ?? this.type,
      codeLines: codeLines ?? this.codeLines,
    );
  }
}

class Quiz {
  final String id;
  final String title;
  final String chapter; // Chapitre d'origine
  final String icon;
  final List<Question> questions;
  int currentQuestionIndex;
  Map<String, String> userAnswers; // questionId → réponse choisie (A, B, C, D)
  Map<String, List<String>> userOrderings; // questionId → ordre choisi

  Quiz({
    required this.id,
    required this.title,
    required this.chapter,
    required this.icon,
    required this.questions,
    this.currentQuestionIndex = 0,
    Map<String, String>? userAnswers,
    Map<String, List<String>>? userOrderings,
  }) : userAnswers = userAnswers ?? {},
       userOrderings = userOrderings ?? {};

  /// Réinitialise le quiz
  void reset() {
    currentQuestionIndex = 0;
    userAnswers.clear();
    userOrderings.clear();
  }

  /// Récupère la question actuelle
  Question get currentQuestion => questions[currentQuestionIndex];

  /// Vérifie si c'est la première question
  bool get isFirstQuestion => currentQuestionIndex == 0;

  /// Vérifie si c'est la dernière question
  bool get isLastQuestion => currentQuestionIndex == questions.length - 1;

  /// Nombre total de questions
  int get totalQuestions => questions.length;
}

/// Classe pour gérer une session de quiz personnalisée
class CustomQuizSession {
  final String id;
  final List<String> selectedChapters;
  final int intensity;
  final List<Quiz> quizzes; // Une quiz par chapitre sélectionné
  int currentQuizIndex;

  CustomQuizSession({
    required this.id,
    required this.selectedChapters,
    required this.intensity,
    required this.quizzes,
    this.currentQuizIndex = 0,
  });

  /// Quiz actuelle
  Quiz get currentQuiz => quizzes[currentQuizIndex];

  /// Passe à la prochaine quiz
  bool nextQuiz() {
    if (currentQuizIndex < quizzes.length - 1) {
      currentQuizIndex++;
      return true;
    }
    return false;
  }

  /// Vérifie si c'est la dernière quiz
  bool get isLastQuiz => currentQuizIndex == quizzes.length - 1;

  /// Calcule le score total
  int getTotalScore() {
    int totalScore = 0;
    for (var quiz in quizzes) {
      totalScore += _calculateQuizScore(quiz);
    }
    return totalScore;
  }

  /// Score total possible
  int get totalPossibleScore =>
      quizzes.fold(0, (sum, quiz) => sum + quiz.totalQuestions);

  /// Calcule le score pour une quiz
  int _calculateQuizScore(Quiz quiz) {
    int score = 0;
    for (var question in quiz.questions) {
      if (question.type == QuestionType.multipleChoice) {
        if (quiz.userAnswers[question.id] == question.bonneReponse) {
          score++;
        }
      } else {
        final userOrder = quiz.userOrderings[question.id];
        if (userOrder != null) {
          final correctOrder = question.bonneReponse.split('|');
          if (userOrder.join('|') == correctOrder.join('|')) {
            score++;
          }
        }
      }
    }
    return score;
  }

  /// Calcule le pourcentage de réussite
  int getPercentage() {
    if (totalPossibleScore == 0) return 0;
    return ((getTotalScore() / totalPossibleScore) * 100).toInt();
  }
}
