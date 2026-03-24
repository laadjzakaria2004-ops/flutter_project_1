import '../../models/dashboard/dashboard_model.dart';
class DashboardController {
  late DashboardModel model;

  DashboardController() {
    model = DashboardModel(
      username: "Zaki",
      role: "Student",
      chapters: [
        ChapterModel(
          number: "Chapitre 01",
          title: "Basics",
          icon: "assets/images/icons_algo1/basics_icone.png",
          lessons: [
            "Définition de l'algorithmique",
            "Caractéristiques d'un algorithme",
            "Types d'algorithmes",
            "Représentation d'un algorithme",
            "jakadkallsllsl",
            "jzjjzjjjssjs",
            "paoksjs,ss",
          ],
        ),
        ChapterModel(
          number: "Chapitre 02",
          title: "Conditions",
          icon: "assets/images/icons_algo1/si_sinon_icon.png",
          lessons: [
            "Introduction aux conditions",
            "If / Else",
            "Switch Case",
            "Conditions imbriquées",
          ],
        ),
        ChapterModel(
          number: "Chapitre 03",
          title: "Loops",
          icon: "assets/images/icons_algo1/loops_icone.png",
          lessons: [
            "Introduction aux boucles",
            "Boucle For",
            "Boucle While",
            "Boucle Do While",
          ],
        ),
        ChapterModel(
          number: "Chapitre 04",
          title: "Data Structures – Vectors and Matrices",
          icon: "assets/images/icons_algo1/vectors_matris_icon.png",
          lessons: [
            "Introduction aux structures",
            "Vecteurs",
            "Matrices",
            "Opérations sur les matrices",
           
          ],
        ),
        ChapterModel(
          number: "Chapitre 05",
          title: "Subprograms (Functions and Procedures)",
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