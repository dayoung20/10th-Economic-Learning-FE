// 댓글 및 답글 모델
class Comment {
  int id;
  String content;
  String author;
  String date;
  int likes;
  bool isAuthor;
  List<Comment> replies;

  Comment({
    required this.id,
    required this.content,
    required this.author,
    required this.date,
    required this.likes,
    required this.isAuthor,
    this.replies = const [],
  });
}
