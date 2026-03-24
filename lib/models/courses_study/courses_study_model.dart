class section {
  final String id;
  final String title;
  final String content;
  final String? imagePath;
  final List<String>? bulletPoints;

  const section({
    required this.id,
    required this.title,
    required this.content,
    this.imagePath,
    this.bulletPoints,
  });
}


