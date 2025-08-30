class Book {
  final int id;
  final String title;
  final String? coverUrl;

  Book({required this.id, required this.title, this.coverUrl});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      coverUrl: json['cover_url'],
    );
  }
}
