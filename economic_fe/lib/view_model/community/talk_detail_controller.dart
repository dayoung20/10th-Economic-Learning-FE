import 'package:economic_fe/data/models/community/comment.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TalkDetailController extends GetxController {
  final RemoteDataSource remoteDataSource = RemoteDataSource(); // 인스턴스 생성

  RxBool isLoading = true.obs;
  RxMap<String, dynamic> postDetail = <String, dynamic>{}.obs;
  RxList<Comment> comments = RxList<Comment>();

  /// 게시글 좋아요 여부
  RxBool isLikedPost = false.obs;

  /// 게시글 스크랩 여부
  RxBool isScrappedPost = false.obs;

  final TextEditingController messageController = TextEditingController();
  var messageText = ''.obs;
  RxBool isModalVisible = false.obs;

  @override
  void onReady() {
    super.onReady();
    int? postId = Get.arguments as int?;
    if (postId != null) {
      fetchPostDetail(postId);
    }
  }

  /// 게시글 상세 조회
  Future<void> fetchPostDetail(int postId) async {
    try {
      isLoading(true);
      final postData = await RemoteDataSource.getTokDetail(postId);

      if (postData != null) {
        postDetail.value = postData;
        comments.value = _parseComments(
            postData['commentListResponse']['commentResponseList']);
        isLikedPost.value = postData['isLiked'];
        isScrappedPost.value = postData['isScraped'];
      }
    } catch (e) {
      print('게시글 상세 조회 중 오류 발생: $e');
    } finally {
      isLoading(false);
    }
  }

  /// 댓글 파싱 (서버 데이터 → Comment 모델)
  List<Comment> _parseComments(List<dynamic> commentList) {
    return commentList.map<Comment>((comment) {
      return Comment(
        id: comment['id'],
        content:
            comment['isDeleted'] == true ? "삭제된 댓글입니다." : comment['content'],
        author: comment['commenterName'] ?? '익명',
        date: comment['createdDate'] ?? '방금 전',
        likes: comment['likeCount'] ?? 0,
        isAuthor: comment['isAuthor'] ?? false, // 현재 사용자가 작성한 댓글인지 확인
        isLiked: comment['isLiked'] ?? false, // 개별 댓글 좋아요 상태 반영
        replies: comment['children'] != null
            ? _parseComments(comment['children']) // 재귀적으로 대댓글 처리
            : [],
        isDeleted: comment['isDeleted'],
      );
    }).toList();
  }

  // 답글을 작성 중인 댓글 ID
  RxInt replyingToCommentId = (-1).obs;
  RxString replyToAuthor = RxString("");

  /// 댓글 입력값 변경 감지
  void updateMessage(String value) {
    messageText.value = value;
  }

  /// 답글 작성 모드 활성화
  void activateReplyMode(int commentId, String author) {
    replyingToCommentId.value = commentId;
    replyToAuthor.value = author;
    messageController.clear();
    messageText.value = '';
    Future.delayed(const Duration(milliseconds: 200), () {
      FocusScope.of(Get.context!).requestFocus(FocusNode()); // 입력창 자동 활성화
    });
  }

  /// 답글 작성 모드 해제 (일반 댓글 작성 모드)
  void disableReplyMode() {
    replyingToCommentId.value = -1;
    replyToAuthor.value = "";
  }

  /// 댓글 또는 답글 추가 요청
  Future<void> sendMessage() async {
    String message = messageController.text;
    if (message.isEmpty) return;

    int postId = postDetail["id"]; // 현재 게시글 ID
    bool success;

    if (replyingToCommentId.value == -1) {
      // 일반 댓글 작성
      success = await RemoteDataSource.addComment(postId, message);
    } else {
      // 답글 작성
      success = await RemoteDataSource.addReply(
          postId, replyingToCommentId.value, message);
    }

    if (success) {
      messageController.clear();
      messageText.value = '';
      replyingToCommentId.value = -1; // 답글 모드 해제
      fetchPostDetail(postId); // 게시글 상세 다시 불러오기 (새로고침)
    } else {
      Get.snackbar("오류", "댓글 작성에 실패했습니다.");
    }
  }

  /// 게시글 좋아요 토글
  void likePostToggle() {
    if (isLikedPost.value) {
      deleteLikedPost();
    } else {
      likePost();
    }
  }

  /// 게시글 좋아요 api 연동
  Future<void> likePost() async {
    int postId = postDetail["id"]; // 현재 게시글 ID
    bool success = await RemoteDataSource.likePost(postId);

    if (success) {
      isLikedPost.value = true;
      fetchPostDetail(postId); // 게시글 상세 다시 불러오기 (새로고침)
    } else {
      Get.snackbar("오류", "게시글 좋아요에 실패했습니다.");
    }
  }

  /// 게시글 좋아요 취소 api 연동
  Future<void> deleteLikedPost() async {
    int postId = postDetail["id"]; // 현재 게시글 ID
    bool success = await RemoteDataSource.deleteLikedPost(postId);

    if (success) {
      isLikedPost.value = false;
      fetchPostDetail(postId); // 게시글 상세 다시 불러오기 (새로고침)
    } else {
      Get.snackbar("오류", "게시글 좋아요 취소에 실패했습니다.");
    }
  }

  /// 게시글 스크랩 토글
  void scrapPostToggle() {
    if (isScrappedPost.value) {
      deleteScrappedPost();
    } else {
      scrapPost();
    }
  }

  /// 게시글 스크랩 api 연동
  Future<void> scrapPost() async {
    int postId = postDetail["id"]; // 현재 게시글 ID
    bool success = await RemoteDataSource.scrapPost(postId);

    if (success) {
      isScrappedPost.value = true;
      fetchPostDetail(postId); // 게시글 상세 다시 불러오기 (새로고침)
    } else {
      Get.snackbar("오류", "게시글 스크랩에 실패했습니다.");
    }
  }

  /// 게시글 스크랩 취소 api 연동
  Future<void> deleteScrappedPost() async {
    int postId = postDetail["id"]; // 현재 게시글 ID
    bool success = await RemoteDataSource.deletePostScrap(postId);

    if (success) {
      isScrappedPost.value = false;
      fetchPostDetail(postId); // 게시글 상세 다시 불러오기 (새로고침)
    } else {
      Get.snackbar("오류", "게시글 스크랩 취소에 실패했습니다.");
    }
  }

  /// 댓글 또는 대댓글 좋아요 토글
  void likeCommentToggle(int commentId) {
    Comment? comment = _findCommentOrReply(commentId);

    if (comment != null) {
      if (comment.isLiked) {
        deleteLikedComment(commentId);
      } else {
        likeComment(commentId);
      }
    }
  }

  /// 댓글 좋아요 api 연동
  Future<void> likeComment(int commentId) async {
    int postId = postDetail["id"];
    bool success = await RemoteDataSource.likeComment(postId, commentId);

    if (success) {
      _updateCommentLikeState(commentId, true);
    } else {
      Get.snackbar("오류", "댓글 좋아요에 실패했습니다.");
    }
  }

  /// 댓글 좋아요 취소 api 연동
  Future<void> deleteLikedComment(int commentId) async {
    int postId = postDetail["id"];
    bool success = await RemoteDataSource.deleteLikedComment(postId, commentId);

    if (success) {
      _updateCommentLikeState(commentId, false);
    } else {
      Get.snackbar("오류", "댓글 좋아요 취소에 실패했습니다.");
    }
  }

  /// 댓글 또는 대댓글 좋아요 상태 업데이트 함수
  void _updateCommentLikeState(int commentId, bool isLiked) {
    // 댓글 리스트 복사 후 특정 댓글을 수정하여 업데이트
    comments.value = comments
        .map((comment) {
          // 일반 댓글인지 확인
          if (comment.id == commentId) {
            return comment.copyWith(
              isLiked: isLiked,
              likes: isLiked ? comment.likes + 1 : comment.likes - 1,
            );
          }

          // 대댓글 탐색 및 수정
          List<Comment> updatedReplies = comment.replies.map((reply) {
            if (reply.id == commentId) {
              return reply.copyWith(
                isLiked: isLiked,
                likes: isLiked ? reply.likes + 1 : reply.likes - 1,
              );
            }
            return reply;
          }).toList();

          return comment.copyWith(replies: updatedReplies);
        })
        .toList()
        .obs;

    comments.refresh();
  }

  /// 특정 댓글 또는 대댓글을 찾는 함수
  Comment? _findCommentOrReply(int commentId) {
    for (var comment in comments) {
      if (comment.id == commentId) return comment;
      for (var reply in comment.replies) {
        if (reply.id == commentId) return reply;
      }
    }
    return null;
  }

  // 댓글 수정 상태 변수
  RxBool isEditingComment = false.obs;
  RxInt editingCommentId = (-1).obs;
  RxString editingCommentText = "".obs;

  // 대댓글 수정 상태 변수
  RxBool isEditingReply = false.obs;
  RxInt editingReplyId = (-1).obs;
  RxString editingReplyText = "".obs;

  /// 댓글 수정 모드 활성화
  void activateEditMode(int commentId, String content) {
    isEditingComment.value = true;
    editingCommentId.value = commentId;
    editingCommentText.value = content;
    messageController.text = content;
  }

  /// 대댓글 수정 모드 활성화
  void activateReplyEditMode(int replyId, String content) {
    isEditingReply.value = true;
    editingReplyId.value = replyId;
    editingReplyText.value = content;
    messageController.text = content;
  }

  /// 댓글 수정 모드 해제
  void disableEditMode() {
    isEditingComment.value = false;
    editingCommentId.value = -1;
    editingCommentText.value = "";
    messageController.clear();
  }

  /// 대댓글 수정 모드 해제
  void disableReplyEditMode() {
    isEditingReply.value = false;
    editingReplyId.value = -1;
    editingReplyText.value = "";
    messageController.clear();
  }

  /// 댓글 수정 API 호출
  Future<void> editComment() async {
    if (messageController.text.isEmpty) return;

    int postId = postDetail["id"];
    int commentId = editingCommentId.value;
    String updatedContent = messageController.text;

    bool success =
        await RemoteDataSource.editComment(postId, commentId, updatedContent);

    if (success) {
      // UI에 즉시 반영
      int index = comments.indexWhere((c) => c.id == commentId);
      if (index != -1) {
        comments[index] = Comment(
          id: comments[index].id,
          content: updatedContent,
          author: comments[index].author,
          date: comments[index].date,
          likes: comments[index].likes,
          isAuthor: comments[index].isAuthor,
          replies: comments[index].replies,
          isLiked: comments[index].isLiked,
          isDeleted: comments[index].isDeleted,
        );
        comments.refresh();
      }
      disableEditMode();
    } else {
      Get.snackbar("오류", "댓글 수정에 실패했습니다.");
    }
  }

  /// 대댓글 수정 API 호출
  Future<void> editReply() async {
    if (messageController.text.isEmpty) return;

    int postId = postDetail["id"];
    int replyId = editingReplyId.value;
    String updatedContent = messageController.text;

    bool success =
        await RemoteDataSource.editComment(postId, replyId, updatedContent);

    if (success) {
      // UI에 즉시 반영
      for (var comment in comments) {
        int replyIndex = comment.replies.indexWhere((r) => r.id == replyId);
        if (replyIndex != -1) {
          comment.replies[replyIndex] = Comment(
            id: replyId,
            content: updatedContent,
            author: comment.replies[replyIndex].author,
            date: comment.replies[replyIndex].date,
            likes: comment.replies[replyIndex].likes,
            isAuthor: comment.replies[replyIndex].isAuthor,
            replies: comment.replies[replyIndex].replies,
            isLiked: comment.replies[replyIndex].isLiked,
            isDeleted: comment.replies[replyIndex].isDeleted,
          );
          comments.refresh();
          break;
        }
      }
      disableReplyEditMode();
    } else {
      Get.snackbar("오류", "대댓글 수정에 실패했습니다.");
    }
  }

  /// 댓글 또는 대댓글 삭제
  Future<void> deleteComment(int commentId) async {
    int postId = postDetail["id"]; // 현재 게시글 ID 가져오기
    debugPrint("삭제 요청: postId = $postId, commentId = $commentId");

    bool success = await RemoteDataSource.deleteComment(postId, commentId);

    if (success) {
      debugPrint("댓글 삭제 성공: $commentId");
      _removeCommentOrReply(commentId); // UI에서 즉시 제거
    } else {
      debugPrint("댓글 삭제 실패: $commentId");
      Get.snackbar("삭제 실패", "댓글 삭제에 실패했습니다.");
    }
  }

  /// 댓글 또는 대댓글을 UI에서 즉시 제거하는 함수
  void _removeCommentOrReply(int commentId) {
    for (var comment in comments) {
      int replyIndex =
          comment.replies.indexWhere((reply) => reply.id == commentId);

      // 대댓글 삭제
      if (replyIndex != -1) {
        comment.replies.removeAt(replyIndex);
        debugPrint("대댓글 삭제됨: $commentId");

        // 모든 대댓글이 삭제되었고 댓글도 삭제 상태라면, 댓글도 삭제
        if (comment.replies.isEmpty && comment.content == "삭제된 댓글입니다.") {
          debugPrint("모든 대댓글 삭제됨, 댓글도 제거: ${comment.id}");
          comments.removeWhere((c) => c.id == comment.id);
        }

        comments.refresh();
        return;
      }
    }

    // 일반 댓글 삭제
    int commentIndex =
        comments.indexWhere((comment) => comment.id == commentId);
    if (commentIndex != -1) {
      comments.removeAt(commentIndex);
      debugPrint("일반 댓글 삭제됨: $commentId");
    }

    comments.refresh();
  }

  /// 옵션 모달 토글
  void toggleModal() {
    isModalVisible.value = !isModalVisible.value;
  }

  // 뒤로 가기
  void goBack() {
    Get.back();
  }

  // 챗봇 화면으로 이동
  void toChatBot() {
    Get.toNamed('/chatbot');
  }
}
