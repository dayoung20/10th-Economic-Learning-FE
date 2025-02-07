class NotificationModel {
  final int id;
  final String postTitle;
  final String content;
  final bool isRead;
  final String type;
  final int postId;
  final String createdDate;

  NotificationModel({
    required this.id,
    required this.postTitle,
    required this.content,
    required this.isRead,
    required this.type,
    required this.postId,
    required this.createdDate,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      postTitle: json['postTitle'],
      content: json['content'],
      isRead: json['isRead'],
      type: json['type'],
      postId: json['postId'],
      createdDate: json['createdDate'],
    );
  }
}
