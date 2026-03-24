class ChapterModel {
  final String number;
  final String title;
  final String icon;
  final List<String> lessons;

  ChapterModel({
    required this.number,
    required this.title,
    required this.icon,
    required this.lessons,
  });
}

class Algo2Model {
  final String username;
  final String role;
  final List<ChapterModel> chapters;
  int? selectedChapterIndex;

  Algo2Model({
    required this.username,
    required this.role,
    required this.chapters,
    this.selectedChapterIndex,
  });
}