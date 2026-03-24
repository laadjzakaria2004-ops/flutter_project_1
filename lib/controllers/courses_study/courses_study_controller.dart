import '../../models/Courses_study/Courses_study_model.dart';

class CourseStudyController {
  final CourseStudyModel model;

  CourseStudyController(this.model);

  void nextPage() {
    if (model.currentPage < model.pages.length - 1) {
      model.currentPage++;
    }
  }

  void prevPage() {
    if (model.currentPage > 0) {
      model.currentPage--;
    }
  }

 

  bool get isFirstPage => model.currentPage == 0;
  bool get isLastPage => model.currentPage == model.pages.length - 1;
}