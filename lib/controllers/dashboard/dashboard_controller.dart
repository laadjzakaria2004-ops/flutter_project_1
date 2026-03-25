import '../../models/dashboard/dashboard_model.dart';

class DashboardController {
  late DashboardModel model;

  DashboardController() {
    model = DashboardModel(
      username: "Zaki",
      role: "Student",
      chapters: [
        ChapterModel(
          id: "Chapitre 01",
          title: "Basics",
          chapterProgress: 100,
          isFinished: false,
          icon: "assets/images/icons_algo1/basics_icone.png",
          xmlPath: "assets/data/algo1/chapitre01.xml", // ← ajouté
          lessons: [
            "Définition de l'algorithmique",
            "Caractéristiques d'un algorithme",
            "Types d'algorithmes",
            "Représentation d'un algorithme",
          ],
        ),
        ChapterModel(
          id: "Chapitre 02",
          title: "Conditions",
          chapterProgress: 120,
          isFinished: false,
          icon: "assets/images/icons_algo1/si_sinon_icon.png",
          xmlPath: "assets/data/algo1/chapitre02.xml", // ← ajouté
          lessons: [
            "Introduction aux conditions",
            "If / Else",
            "Switch Case",
            "Conditions imbriquées",
          ],
        ),
        ChapterModel(
          id: "Chapitre 03",
          title: "Loops",
          chapterProgress: 150,
          isFinished: false,
          icon: "assets/images/icons_algo1/loops_icone.png",
          xmlPath: "assets/data/algo1/chapitre03.xml", // ← ajouté
          lessons: [
            "Introduction aux boucles",
            "Boucle For",
            "Boucle While",
            "Boucle Do While",
          ],
        ),
        ChapterModel(
          id: "Chapitre 04",
          title: "Data Structures – Vectors and Matrices",
          chapterProgress: 180,
          isFinished: false,
          icon: "assets/images/icons_algo1/vectors_matris_icon.png",
          xmlPath: "assets/data/algo1/chapitre04.xml", // ← ajouté
          lessons: [
            "Introduction aux structures",
            "Vecteurs",
            "Matrices",
            "Opérations sur les matrices",
          ],
        ),
        ChapterModel(
          id: "Chapitre 05",
          title: "Subprograms (Functions and Procedures)",
          chapterProgress: 200,
          isFinished: false,
          icon: "assets/images/icons_algo1/fonction_procedure_icone.png",
          xmlPath: "assets/data/algo1/chapitre05.xml", // ← ajouté
          lessons: [
            "Introduction aux sous-programmes",
            "Fonctions",
            "Procédures",
            "Récursivité",
          ],
        ),
      ],
    );
  }

  void selectChapter(int index) {
    model.selectedChapterIndex = index;
  }

  List<String> getSelectedLessons() {
    if (model.selectedChapterIndex == null) return [];
    return model.chapters[model.selectedChapterIndex!].lessons;
  }

  String getSelectedChapterTitle() {
    if (model.selectedChapterIndex == null) return '';
    return model.chapters[model.selectedChapterIndex!].title;
  }
}