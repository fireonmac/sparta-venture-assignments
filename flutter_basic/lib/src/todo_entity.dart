class TodoEntity {
  String title;
  String? description;
  bool isFavorite;
  bool isDone;

  TodoEntity({
    required this.title,
    this.description,
    required this.isFavorite,
    required this.isDone,
  });
}
