

class CoursePageContent {
  final String title;
  final String content;
  final String? imagePath;
  final List<String>? bulletPoints;

  const CoursePageContent({
    required this.title,
    required this.content,
    this.imagePath,
    this.bulletPoints,
  });
}

class CourseStudyModel {
  final String chapterTitle;
  final String chapterSubtitle;
  final List<CoursePageContent> pages;

  int currentPage;

  CourseStudyModel({
    required this.chapterTitle,
    required this.chapterSubtitle,
    required this.pages,
    this.currentPage = 0,
  });
}