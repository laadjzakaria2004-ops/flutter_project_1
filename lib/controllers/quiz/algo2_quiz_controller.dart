
import '../quiz/quiz_controller.dart';
import '../../models/quiz/quiz_model.dart';

class Algo2QuizController extends QuizController {
  late CustomQuizSession _session;

  CustomQuizSession get session => _session;

  /// Base de données des questions pour Algo 2
  static const List<Map<String, dynamic>> _algo2QuestionsDatabase = [
    // ========== ALGO 2 - CHAPITRE 01: ADVANCED ALGORITHM ANALYSIS ==========
    {
      'id': 'a2_c1_q1',
      'chapter': 'Algo2 Chapitre 01',
      'enonce': 'What is the Master Theorem used for?',
      'reponseA': 'Sorting arrays',
      'reponseB': 'Solving recurrence relations',
      'reponseC': 'Graph traversal',
      'reponseD': 'Dynamic programming',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c1_q2',
      'chapter': 'Algo2 Chapitre 01',
      'enonce': 'What is amortized analysis?',
      'reponseA': 'Average time per operation over a sequence',
      'reponseB': 'Worst-case analysis',
      'reponseC': 'Best-case analysis',
      'reponseD': 'Space complexity analysis',
      'bonneReponse': 'A',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c1_q3',
      'chapter': 'Algo2 Chapitre 01',
      'enonce': 'Solve T(n) = 2T(n/2) + n using Master Theorem',
      'reponseA': 'O(n)',
      'reponseB': 'O(n log n)',
      'reponseC': 'O(n²)',
      'reponseD': 'O(log n)',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c1_q4',
      'chapter': 'Algo2 Chapitre 01',
      'enonce': 'What is the time complexity of binary search?',
      'reponseA': 'O(n)',
      'reponseB': 'O(log n)',
      'reponseC': 'O(n log n)',
      'reponseD': 'O(1)',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c1_q5',
      'chapter': 'Algo2 Chapitre 01',
      'enonce': 'Order the complexity classes from smallest to largest:',
      'reponseA': '',
      'reponseB': '',
      'reponseC': '',
      'reponseD': '',
      'bonneReponse': 'O(1)|O(log n)|O(n)|O(n log n)|O(n²)',
      'type': 'ordering',
      'codeLines': ['O(n²)', 'O(log n)', 'O(n log n)', 'O(1)', 'O(n)'],
    },

    // ========== ALGO 2 - CHAPITRE 02: ADVANCED SORTING ALGORITHMS ==========
    {
      'id': 'a2_c2_q1',
      'chapter': 'Algo2 Chapitre 02',
      'enonce': 'What is the average time complexity of QuickSort?',
      'reponseA': 'O(n)',
      'reponseB': 'O(n log n)',
      'reponseC': 'O(n²)',
      'reponseD': 'O(log n)',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c2_q2',
      'chapter': 'Algo2 Chapitre 02',
      'enonce': 'Which sorting algorithm is stable?',
      'reponseA': 'QuickSort',
      'reponseB': 'HeapSort',
      'reponseC': 'MergeSort',
      'reponseD': 'Selection Sort',
      'bonneReponse': 'C',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c2_q3',
      'chapter': 'Algo2 Chapitre 02',
      'enonce': 'What is the worst-case time complexity of QuickSort?',
      'reponseA': 'O(n)',
      'reponseB': 'O(n log n)',
      'reponseC': 'O(n²)',
      'reponseD': 'O(log n)',
      'bonneReponse': 'C',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c2_q4',
      'chapter': 'Algo2 Chapitre 02',
      'enonce': 'Which sorting algorithm uses a heap data structure?',
      'reponseA': 'QuickSort',
      'reponseB': 'MergeSort',
      'reponseC': 'HeapSort',
      'reponseD': 'Radix Sort',
      'bonneReponse': 'C',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c2_q5',
      'chapter': 'Algo2 Chapitre 02',
      'enonce': 'Order the steps of QuickSort:',
      'reponseA': '',
      'reponseB': '',
      'reponseC': '',
      'reponseD': '',
      'bonneReponse': 'Choose pivot|Partition array|Recursively sort left|Recursively sort right',
      'type': 'ordering',
      'codeLines': ['Recursively sort right', 'Partition array', 'Recursively sort left', 'Choose pivot'],
    },

    // ========== ALGO 2 - CHAPITRE 03: GRAPH ALGORITHMS ==========
    {
      'id': 'a2_c3_q1',
      'chapter': 'Algo2 Chapitre 03',
      'enonce': "What is Dijkstra's algorithm used for?",
      'reponseA': 'Finding minimum spanning tree',
      'reponseB': 'Finding shortest path in weighted graph',
      'reponseC': 'Graph traversal',
      'reponseD': 'Topological sorting',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c3_q2',
      'chapter': 'Algo2 Chapitre 03',
      'enonce': 'What is the time complexity of DFS on a graph with V vertices and E edges?',
      'reponseA': 'O(V)',
      'reponseB': 'O(E)',
      'reponseC': 'O(V + E)',
      'reponseD': 'O(V * E)',
      'bonneReponse': 'C',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c3_q3',
      'chapter': 'Algo2 Chapitre 03',
      'enonce': 'Which algorithm finds the minimum spanning tree?',
      'reponseA': "Dijkstra's algorithm",
      'reponseB': 'Bellman-Ford',
      'reponseC': "Prim's algorithm",
      'reponseD': 'Floyd-Warshall',
      'bonneReponse': 'C',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c3_q4',
      'chapter': 'Algo2 Chapitre 03',
      'enonce': 'What does BFS guarantee?',
      'reponseA': 'Shortest path in weighted graph',
      'reponseB': 'Shortest path in unweighted graph',
      'reponseC': 'Minimum spanning tree',
      'reponseD': 'Topological order',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c3_q5',
      'chapter': 'Algo2 Chapitre 03',
      'enonce': 'Order the steps of Dijkstra algorithm:',
      'reponseA': '',
      'reponseB': '',
      'reponseC': '',
      'reponseD': '',
      'bonneReponse': 'Initialize distances|Set source distance 0|Extract min vertex|Update neighbors',
      'type': 'ordering',
      'codeLines': ['Extract min vertex', 'Initialize distances', 'Set source distance 0', 'Update neighbors'],
    },

    // ========== ALGO 2 - CHAPITRE 04: DYNAMIC PROGRAMMING ==========
    {
      'id': 'a2_c4_q1',
      'chapter': 'Algo2 Chapitre 04',
      'enonce': 'What is memoization?',
      'reponseA': 'Storing results of expensive function calls',
      'reponseB': 'A sorting technique',
      'reponseC': 'A graph algorithm',
      'reponseD': 'A greedy approach',
      'bonneReponse': 'A',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c4_q2',
      'chapter': 'Algo2 Chapitre 04',
      'enonce': 'What is the difference between memoization and tabulation?',
      'reponseA': 'Memoization is bottom-up, tabulation is top-down',
      'reponseB': 'Memoization is top-down, tabulation is bottom-up',
      'reponseC': 'They are the same',
      'reponseD': 'Memoization uses iteration',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c4_q3',
      'chapter': 'Algo2 Chapitre 04',
      'enonce': 'What is the 0/1 Knapsack problem?',
      'reponseA': 'Items can be taken fractionally',
      'reponseB': 'Items can be taken or not taken',
      'reponseC': 'All items must be taken',
      'reponseD': 'Items have no weight',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c4_q4',
      'chapter': 'Algo2 Chapitre 04',
      'enonce': 'What is the Longest Common Subsequence problem?',
      'reponseA': 'Finding longest substring',
      'reponseB': 'Finding longest sequence present in both strings',
      'reponseC': 'Finding longest palindrome',
      'reponseD': 'Finding shortest path',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c4_q5',
      'chapter': 'Algo2 Chapitre 04',
      'enonce': 'Order the steps of dynamic programming:',
      'reponseA': '',
      'reponseB': '',
      'reponseC': '',
      'reponseD': '',
      'bonneReponse': 'Identify subproblems|Define recurrence|Solve base cases|Compute optimal solution',
      'type': 'ordering',
      'codeLines': ['Identify subproblems', 'Define recurrence', 'Compute optimal solution', 'Solve base cases'],
    },

    // ========== ALGO 2 - CHAPITRE 05: GREEDY ALGORITHMS ==========
    {
      'id': 'a2_c5_q1',
      'chapter': 'Algo2 Chapitre 05',
      'enonce': 'What is a greedy algorithm?',
      'reponseA': 'Makes locally optimal choice at each step',
      'reponseB': 'Explores all possibilities',
      'reponseC': 'Uses recursion',
      'reponseD': 'Divides problem into subproblems',
      'bonneReponse': 'A',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c5_q2',
      'chapter': 'Algo2 Chapitre 05',
      'enonce': 'Which problem can be solved optimally with a greedy approach?',
      'reponseA': '0/1 Knapsack',
      'reponseB': 'Fractional Knapsack',
      'reponseC': 'Traveling Salesman',
      'reponseD': 'Graph coloring',
      'bonneReponse': 'B',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c5_q3',
      'chapter': 'Algo2 Chapitre 05',
      'enonce': 'What is Huffman coding used for?',
      'reponseA': 'Data compression',
      'reponseB': 'Encryption',
      'reponseC': 'Sorting',
      'reponseD': 'Searching',
      'bonneReponse': 'A',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c5_q4',
      'chapter': 'Algo2 Chapitre 05',
      'enonce': 'What is the Activity Selection problem?',
      'reponseA': 'Select maximum non-overlapping activities',
      'reponseB': 'Select activities with maximum profit',
      'reponseC': 'Sort activities by duration',
      'reponseD': 'Find shortest path',
      'bonneReponse': 'A',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c5_q5',
      'chapter': 'Algo2 Chapitre 05',
      'enonce': 'Order the steps of Huffman coding:',
      'reponseA': '',
      'reponseB': '',
      'reponseC': '',
      'reponseD': '',
      'bonneReponse': 'Calculate frequencies|Create leaf nodes|Build priority queue|Extract two smallest|Combine into new node',
      'type': 'ordering',
      'codeLines': ['Extract two smallest', 'Calculate frequencies', 'Create leaf nodes', 'Build priority queue', 'Combine into new node'],
    },

    // ========== ALGO 2 - CHAPITRE 06: NP-COMPLETENESS ==========
    {
      'id': 'a2_c6_q1',
      'chapter': 'Algo2 Chapitre 06',
      'enonce': 'What is P vs NP?',
      'reponseA': 'P is subset of NP',
      'reponseB': 'NP is subset of P',
      'reponseC': 'They are equal',
      'reponseD': 'They are unrelated',
      'bonneReponse': 'A',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c6_q2',
      'chapter': 'Algo2 Chapitre 06',
      'enonce': 'What is an NP-Complete problem?',
      'reponseA': 'Problem in NP and NP-hard',
      'reponseB': 'Problem solvable in polynomial time',
      'reponseC': 'Problem with no solution',
      'reponseD': 'Problem with exponential solution',
      'bonneReponse': 'A',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c6_q3',
      'chapter': 'Algo2 Chapitre 06',
      'enonce': 'What is the Traveling Salesman Problem?',
      'reponseA': 'Find shortest path visiting all cities',
      'reponseB': 'Find minimum spanning tree',
      'reponseC': 'Find shortest path between two cities',
      'reponseD': 'Find maximum flow',
      'bonneReponse': 'A',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c6_q4',
      'chapter': 'Algo2 Chapitre 06',
      'enonce': 'What is a reduction in complexity theory?',
      'reponseA': 'Transforming one problem to another',
      'reponseB': 'Reducing time complexity',
      'reponseC': 'Reducing space complexity',
      'reponseD': 'Simplifying code',
      'bonneReponse': 'A',
      'type': 'multipleChoice',
      'codeLines': null,
    },
    {
      'id': 'a2_c6_q5',
      'chapter': 'Algo2 Chapitre 06',
      'enonce': 'Order the complexity classes from easiest to hardest:',
      'reponseA': '',
      'reponseB': '',
      'reponseC': '',
      'reponseD': '',
      'bonneReponse': 'P|NP|NP-Complete|NP-Hard',
      'type': 'ordering',
      'codeLines': ['NP-Hard', 'P', 'NP', 'NP-Complete'],
    },
  ];

  Algo2QuizController({
    required List<String> selectedChapters,
    required int intensity,
  }) : super(
          selectedChapters: selectedChapters,
          intensity: intensity,
        ) {
    _initializeSession(selectedChapters, intensity);
  }

  void _initializeSession(List<String> selectedChapters, int intensity) {
    List<Quiz> quizzes = [];

    for (var chapter in selectedChapters) {
      final chapterQuestions = _getQuestionsByChapter(chapter);
      final selectedQuestions = chapterQuestions.take(intensity).toList();

      final quiz = Quiz(
        id: 'quiz_${chapter.replaceAll(' ', '_')}',
        title: chapter,
        chapter: chapter,
        icon: _getIconForChapter(chapter),
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

  String _getIconForChapter(String chapter) {
    switch (chapter) {
      case 'Algo2 Chapitre 01':
        return 'assets/images/icons_algo2/advanced_analysis.png';
      case 'Algo2 Chapitre 02':
        return 'assets/images/icons_algo2/advanced_sorting.png';
      case 'Algo2 Chapitre 03':
        return 'assets/images/icons_algo2/graph_algorithms.png';
      case 'Algo2 Chapitre 04':
        return 'assets/images/icons_algo2/dynamic_programming.png';
      case 'Algo2 Chapitre 05':
        return 'assets/images/icons_algo2/greedy_algorithms.png';
      case 'Algo2 Chapitre 06':
        return 'assets/images/icons_algo2/np_completeness.png';
      default:
        return 'assets/images/icons_algo2/default.png';
    }
  }

  List<Question> _getQuestionsByChapter(String chapter) {
    return _algo2QuestionsDatabase
        .where((q) => q['chapter'] == chapter)
        .map((q) => _mapToQuestion(q))
        .toList();
  }

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
  void nextQuestion() {
    if (!_session.currentQuiz.isLastQuestion) {
      _session.currentQuiz.currentQuestionIndex++;
    }
  }

  void prevQuestion() {
    if (!_session.currentQuiz.isFirstQuestion) {
      _session.currentQuiz.currentQuestionIndex--;
    }
  }

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
  void answerMultipleChoice(String questionId, String answer) {
    _session.currentQuiz.userAnswers[questionId] = answer;
  }

  void setOrdering(String questionId, List<String> order) {
    _session.currentQuiz.userOrderings[questionId] = order;
  }

  // ========== VÉRIFICATION ==========
  bool checkAnswer(String questionId) {
    final question = _session.currentQuiz.questions
        .firstWhere((q) => q.id == questionId);

    if (question.type == QuestionType.multipleChoice) {
      return _session.currentQuiz.userAnswers[questionId] == question.bonneReponse;
    } else {
      final userOrder = _session.currentQuiz.userOrderings[questionId];
      if (userOrder == null) return false;
      final correctOrder = question.bonneReponse.split('|');
      return userOrder.join('|') == correctOrder.join('|');
    }
  }

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
  int getCurrentQuizScore() {
    int score = 0;
    for (var question in _session.currentQuiz.questions) {
      if (getQuestionStatus(question.id) == true) {
        score++;
      }
    }
    return score;
  }

  int getTotalScore() {
    return _session.getTotalScore();
  }

  int getPercentage() {
    return _session.getPercentage();
  }

  void resetSession() {
    for (var quiz in _session.quizzes) {
      quiz.reset();
    }
    _session.currentQuizIndex = 0;
  }
}