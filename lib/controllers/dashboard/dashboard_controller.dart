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

  // Sélectionner un chapitre
  void selectChapter(int index) {
    model.selectedChapterIndex = index;
  }

  // Récupérer les leçons du chapitre sélectionné
  List<String> getSelectedLessons() {
    if (model.selectedChapterIndex == null) return [];
    return model.chapters[model.selectedChapterIndex!].lessons;
  }

  // Titre du chapitre sélectionné
  String getSelectedChapterTitle() {
    if (model.selectedChapterIndex == null) return '';
    return model.chapters[model.selectedChapterIndex!].title;
  }
}