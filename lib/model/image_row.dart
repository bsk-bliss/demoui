class ImageRow {
  final String imageName, title, description, tagName;
  final int lessons;
  final bool tag;

  ImageRow(
      {required this.imageName,
      required this.title,
      required this.description,
      required this.lessons,
      this.tag = false,
      this.tagName = ""});
}
