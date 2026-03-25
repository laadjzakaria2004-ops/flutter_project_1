// controllers/quiz/quiz_controller.dart

import '../../models/quiz/quiz_model.dart';

class QuizController {
  late CustomQuizSession _session;

  CustomQuizSession get session => _session;

  /// Table des questions en base de données (à remplacer par SQL)
  /// CHANGEMENT POUR SQL: Remplacer par un appel à la base de données
  /// final List<Question> _allQuestions = await _databaseService.getAllQuestions();
  static const List<Map<String, dynamic>> _questionsDatabase = [
    // ========== CHAPITRE 01: BASICS ==========
    {
      'id': 'c1_q1',
      'chapter': 'Chapitre 01',
      'enonce': 'What is an algorithm?',
      'reponseA': 'A programming language',
      'reponseB': 'A step-by-step procedure for solving a problem',
      'reponseC': 'A type of computer',
      'reponseD': 'A data structure',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'c1_q2',
      'chapter': 'Chapitre 01',
      'enonce': 'Which of the following is NOT a characteristic of an algorithm?',
      'reponseA': 'Finiteness',
      'reponseB': 'Definiteness',
      'reponseC': 'Ambiguity',
      'reponseD': 'Effectiveness',
      'bonneReponse': 'C',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'c1_q3',
      'chapter': 'Chapitre 01',
      'enonce': 'What is the time complexity of searching in an unsorted array?',
      'reponseA': 'O(1)',
      'reponseB': 'O(n)',
      'reponseC': 'O(log n)',
      'reponseD': 'O(n²)',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'c1_q4',
      'chapter': 'Chapitre 01',
      'enonce': 'Which is the best time complexity for a search algorithm?',
      'reponseA': 'O(n)',
      'reponseB': 'O(log n)',
      'reponseC': 'O(1)',
      'reponseD': 'O(n log n)',
      'bonneReponse': 'C',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'c1_q5',
      'chapter': 'Chapitre 01',
      'enonce': 'What does "Big O" notation describe?',
      'reponseA': 'Memory usage',
      'reponseB': 'Time complexity in worst case',
      'reponseC': 'The number of lines of code',
      'reponseD': 'CPU speed',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    // ========== CHAPITRE 02: CONDITIONS ==========
    {
      'id': 'c2_q1',
      'chapter': 'Chapitre 02',
      'enonce': 'What does an "if-else" statement do?',
      'reponseA': 'Loop execution',
      'reponseB': 'Conditional execution',
      'reponseC': 'Function definition',
      'reponseD': 'Variable declaration',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'c2_q2',
      'chapter': 'Chapitre 02',
      'enonce': 'Which keyword is used for multiple conditions?',
      'reponseA': 'switch',
      'reponseB': 'while',
      'reponseC': 'for',
      'reponseD': 'foreach',
      'bonneReponse': 'A',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'c2_q3',
      'chapter': 'Chapitre 02',
      'enonce': 'What is the logical operator for AND?',
      'reponseA': '|',
      'reponseB': '||',
      'reponseC': '&&',
      'reponseD': '&',
      'bonneReponse': 'C',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'c2_q4',
      'chapter': 'Chapitre 02',
      'enonce': 'What is the logical operator for OR?',
      'reponseA': '&&',
      'reponseB': '||',
      'reponseC': '&',
      'reponseD': '!',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'c2_q5',
      'chapter': 'Chapitre 02',
      'enonce': 'What does the NOT operator (!) do?',
      'reponseA': 'Inverts a boolean value',
      'reponseB': 'Adds two numbers',
      'reponseC': 'Compares two values',
      'reponseD': 'Declares a variable',
      'bonneReponse': 'A',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    // ========== CHAPITRE 03: LOOPS ==========
    {
      'id': 'c3_q1',
      'chapter': 'Chapitre 03',
      'enonce': 'Order the steps for a for loop:',
      'reponseA': '',
      'reponseB': '',
      'reponseC': '',
      'reponseD': '',
      'bonneReponse': 'Initialization|Condition|Body|Increment',
      'type': 'ordering',
      'codeLines': ['Body', 'Initialization', 'Increment', 'Condition'],
    },
    {
      'id': 'c3_q2',
      'chapter': 'Chapitre 03',
      'enonce': 'What is the purpose of a while loop?',
      'reponseA': 'Execute code a fixed number of times',
      'reponseB': 'Execute code while a condition is true',
      'reponseC': 'Define a function',
      'reponseD': 'Create an array',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'c3_q3',
      'chapter': 'Chapitre 03',
      'enonce': 'What is the key difference between for and while loops?',
      'reponseA': 'for is faster',
      'reponseB': 'while cannot iterate',
      'reponseC': 'for has a predefined iteration count',
      'reponseD': 'They are identical',
      'bonneReponse': 'C',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'c3_q4',
      'chapter': 'Chapitre 03',
      'enonce': 'What does "break" statement do in a loop?',
      'reponseA': 'Pauses the loop',
      'reponseB': 'Exits the loop immediately',
      'reponseC': 'Restarts the loop',
      'reponseD': 'Increases the iteration',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'c3_q5',
      'chapter': 'Chapitre 03',
      'enonce': 'What does "continue" statement do?',
      'reponseA': 'Exits the loop',
      'reponseB': 'Pauses the execution',
      'reponseC': 'Skips to the next iteration',
      'reponseD': 'Repeats the current iteration',
      'bonneReponse': 'C',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    // ========== CHAPITRE 04: DATA STRUCTURES ==========
    {
      'id': 'c4_q1',
      'chapter': 'Chapitre 04',
      'enonce': 'What is a vector?',
      'reponseA': 'A fixed-size array',
      'reponseB': 'A dynamic array that can grow or shrink',
      'reponseC': 'A constant value',
      'reponseD': 'A function parameter',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'c4_q2',
      'chapter': 'Chapitre 04',
      'enonce': 'What is the time complexity of accessing an element in an array?',
      'reponseA': 'O(n)',
      'reponseB': 'O(log n)',
      'reponseC': 'O(1)',
      'reponseD': 'O(n²)',
      'bonneReponse': 'C',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'c4_q3',
      'chapter': 'Chapitre 04',
      'enonce': 'What is a matrix?',
      'reponseA': 'A one-dimensional array',
      'reponseB': 'A two-dimensional array',
      'reponseC': 'A dynamic array',
      'reponseD': 'A type of vector',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'c4_q4',
      'chapter': 'Chapitre 04',
      'enonce': 'Order the steps for matrix traversal:',
      'reponseA': '',
      'reponseB': '',
      'reponseC': '',
      'reponseD': '',
      'bonneReponse': 'Initialize row index|Initialize column index|Access element|Move to next element',
      'type': 'ordering',
      'codeLines': ['Access element', 'Initialize row index', 'Move to next element', 'Initialize column index'],
    },
    {
      'id': 'c4_q5',
      'chapter': 'Chapitre 04',
      'enonce': 'What is the advantage of using vectors over arrays?',
      'reponseA': 'Faster access',
      'reponseB': 'Dynamic sizing',
      'reponseC': 'Less memory usage',
      'reponseD': 'No advantages',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    // ========== CHAPITRE 05: FUNCTIONS ==========
    {
      'id': 'c5_q1',
      'chapter': 'Chapitre 05',
      'enonce': 'What is a function?',
      'reponseA': 'A variable',
      'reponseB': 'A reusable block of code that performs a task',
      'reponseC': 'A loop',
      'reponseD': 'A data type',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'c5_q2',
      'chapter': 'Chapitre 05',
      'enonce': 'What are parameters in a function?',
      'reponseA': 'The function name',
      'reponseB': 'Input values passed to the function',
      'reponseC': 'The function body',
      'reponseD': 'The return type',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'c5_q3',
      'chapter': 'Chapitre 05',
      'enonce': 'What is recursion?',
      'reponseA': 'A loop',
      'reponseB': 'A function calling itself',
      'reponseC': 'A data structure',
      'reponseD': 'An array operation',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'c5_q4',
      'chapter': 'Chapitre 05',
      'enonce': 'What is the base case in recursion?',
      'reponseA': 'The first function call',
      'reponseB': 'The condition to stop recursion',
      'reponseC': 'The return value',
      'reponseD': 'The function parameters',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'c5_q5',
      'chapter': 'Chapitre 05',
      'enonce': 'Order the function execution steps:',
      'reponseA': '',
      'reponseB': '',
      'reponseC': '',
      'reponseD': '',
      'bonneReponse': 'Function declaration|Function call|Parameter passing|Function execution|Return value',
      'type': 'ordering',
      'codeLines': ['Function execution', 'Function declaration', 'Return value', 'Function call', 'Parameter passing'],
    },
  ];

  QuizController({
    required List<String> selectedChapters,
    required int intensity,
  }) {
    _initializeSession(selectedChapters, intensity);
  }

  /// Initialise la session de quiz
  void _initializeSession(List<String> selectedChapters, int intensity) {
    List<Quiz> quizzes = [];

    for (var chapter in selectedChapters) {
      // Récupérer les questions du chapitre
      final chapterQuestions = _getQuestionsByChapter(chapter);
      
      // Prendre les questions selon l'intensité
      final selectedQuestions = chapterQuestions.take(intensity).toList();

      // Créer une quiz pour ce chapitre
      final quiz = Quiz(
        id: 'quiz_${chapter.replaceAll(' ', '_')}',
        title: chapter,
        chapter: chapter,
        icon:"assets/images/icons_algo1/basics_icone.png" ,
        questions: selectedQuestions,

      );

      quizzes.add(quiz);
    }

    _session = CustomQuizSession(
      id: 'session_${DateTime.now().millisecondsSinceEpoch}',
      selectedChapters: selectedChapters,
      intensity: intensity,
      quizzes: quizzes,
    );
  }

  /// Récupère les questions d'un chapitre depuis la base de données
  /// CHANGEMENT POUR SQL:
  /// Remplacer par: final questions = await _databaseService.getQuestionsByChapter(chapter);
  List<Question> _getQuestionsByChapter(String chapter) {
    return _questionsDatabase
        .where((q) => q['chapter'] == chapter)
        .map((q) => _mapToQuestion(q))
        .toList();
  }

  /// Convertit une entrée de la base de données en objet Question
  /// CHANGEMENT POUR SQL: Cette méthode restera la même
  Question _mapToQuestion(Map<String, dynamic> data) {
    return Question(
      id: data['id'],
      enonce: data['enonce'],
      reponseA: data['reponseA'],
      reponseB: data['reponseB'],
      reponseC: data['reponseC'],
      reponseD: data['reponseD'],
      bonneReponse: data['bonneReponse'],
      type: data['type'] == 'ordering' ? QuestionType.ordering : QuestionType.multipleChoice,
      codeLines: data['codeLines'] as List<String>?,
    );
  }

  // ========== NAVIGATION ==========
  
  /// Passe à la question suivante
  void nextQuestion() {
    if (!_session.currentQuiz.isLastQuestion) {
      _session.currentQuiz.currentQuestionIndex++;
    }
  }

  /// Retourne à la question précédente
  void prevQuestion() {
    if (!_session.currentQuiz.isFirstQuestion) {
      _session.currentQuiz.currentQuestionIndex--;
    }
  }

  /// Passe à la quiz suivante
  bool nextQuiz() {
    return _session.nextQuiz();
  }

  // ========== GETTERS ==========

  bool get isFirstQuestion => _session.currentQuiz.isFirstQuestion;
  bool get isLastQuestion => _session.currentQuiz.isLastQuestion;
  bool get isLastQuiz => _session.isLastQuiz;
  
  int get totalQuestionsInCurrentQuiz => _session.currentQuiz.totalQuestions;
  int get currentQuestionIndex => _session.currentQuiz.currentQuestionIndex;
  Question get currentQuestion => _session.currentQuiz.currentQuestion;
  
  Quiz get currentQuiz => _session.currentQuiz;

  // ========== RÉPONSES ==========

  /// Enregistre une réponse pour une question multiple choice
  void answerMultipleChoice(String questionId, String answer) {
    _session.currentQuiz.userAnswers[questionId] = answer;
  }

  /// Enregistre l'ordre pour une question ordering
  void setOrdering(String questionId, List<String> order) {
    _session.currentQuiz.userOrderings[questionId] = order;
  }

  // ========== VÉRIFICATION ==========

  /// Vérifie la réponse et retourne true si correcte
  bool checkAnswer(String questionId) {
    final question = _session.currentQuiz.questions
        .firstWhere((q) => q.id == questionId);

    if (question.type == QuestionType.multipleChoice) {
      return _session.currentQuiz.userAnswers[questionId] == 
             question.bonneReponse;
    } else {
      final userOrder = _session.currentQuiz.userOrderings[questionId];
      if (userOrder == null) return false;
      
      final correctOrder = question.bonneReponse.split('|');
      return userOrder.join('|') == correctOrder.join('|');
    }
  }

  /// Obtient le statut d'une question (correct, incorrect, non répondue)
  bool? getQuestionStatus(String questionId) {
    final question = _session.currentQuiz.questions
        .firstWhere((q) => q.id == questionId);

    if (question.type == QuestionType.multipleChoice) {
      if (!_session.currentQuiz.userAnswers.containsKey(questionId)) {
        return null;
      }
    } else {
      if (!_session.currentQuiz.userOrderings.containsKey(questionId)) {
        return null;
      }
    }
    
    return checkAnswer(questionId);
  }

  // ========== SCORES ==========

  /// Obtient le score de la quiz actuelle
  int getCurrentQuizScore() {
    int score = 0;
    for (var question in _session.currentQuiz.questions) {
      if (getQuestionStatus(question.id) == true) {
        score++;
      }
    }
    return score;
  }

  /// Obtient le score total de toute la session
  int getTotalScore() {
    return _session.getTotalScore();
  }

  /// Obtient le pourcentage de réussite
  int getPercentage() {
    return _session.getPercentage();
  }

  /// Réinitialise la session
  void resetSession() {
    for (var quiz in _session.quizzes) {
      quiz.reset();
    }
    _session.currentQuizIndex = 0;
  }
}