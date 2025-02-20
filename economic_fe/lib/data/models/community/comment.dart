// 댓글 및 답글 모델
class Comment {
  int id;
  String content;
  String author;
  String date;
  int likes;
  bool isLiked;
  bool isAuthor;
  bool isDeleted;
  List<Comment> replies;
  int? commenterId;
  String? commenterProfileImageUrl;

  Comment({
    required this.id,
    required this.content,
    required this.author,
    required this.date,
    required this.likes,
    required this.isLiked,
    required this.isAuthor,
    required this.isDeleted,
    this.replies = const [],
    this.commenterId,
    this.commenterProfileImageUrl,
  });

  /// copyWith method to create a modified copy of the Comment object
  Comment copyWith({
    int? id,
    String? content,
    String? author,
    String? date,
    int? likes,
    bool? isAuthor,
    bool? isLiked,
    bool? isDeleted,
    List<Comment>? replies,
    int? commenterId,
    String? commenterProfileImageUrl,
  }) {
    return Comment(
      id: id ?? this.id,
      content: content ?? this.content,
      author: author ?? this.author,
      date: date ?? this.date,
      likes: likes ?? this.likes,
      isAuthor: isAuthor ?? this.isAuthor,
      isLiked: isLiked ?? this.isLiked,
      isDeleted: isDeleted ?? this.isDeleted,
      replies: replies ?? this.replies,
      commenterId: commenterId ?? this.commenterId,
      commenterProfileImageUrl:
          commenterProfileImageUrl ?? this.commenterProfileImageUrl,
    );
  }
}
