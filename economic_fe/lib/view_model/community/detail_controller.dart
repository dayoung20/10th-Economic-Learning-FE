import 'package:economic_fe/data/models/community/comment.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final RemoteDataSource remoteDataSource = RemoteDataSource(); // 인스턴스 생성

  RxInt currentPostId = (-1).obs;

  RxBool isLoading = true.obs;
  RxMap<String, dynamic> postDetail = <String, dynamic>{}.obs;
  RxList<Comment> comments = RxList<Comment>();
  RxBool isAuthor = false.obs;
  RxList<int> myPostIds = <int>[].obs; // 내가 작성한 게시물 id
  RxList<int> likedPostIds = <int>[].obs; // 내가 좋아요 한 게시물 id
  RxList<int> scrappedPostIds = <int>[].obs; // 내가 스크랩 한 게시물 id
  // RxMap<int, bool> likedCommentMap = <int, bool>{}.obs; // 각 댓글별 좋아요 상태

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
      final postData = await remoteDataSource.getPostDetail(postId);

      if (postData != null) {
        postData["id"] = postId; // ✅ 명시적으로 ID 설정
        postDetail.value = postData;
        currentPostId.value = postId; // ✅ postId 직접 저장

        isAuthor.value = postData['isAuthor'] ?? false;
        isLikedPost.value = postData['isLiked'] ?? false;
        isScrappedPost.value = postData['isScraped'] ?? false;

        comments.value = _parseComments(postData['commentList'] ?? []);
      }
    } catch (e) {
      print('게시글 상세 조회 중 오류 발생: $e');
    } finally {
      isLoading(false);
    }
  }

  /// 댓글 파싱 (서버 데이터 → Comment 모델)
  List<Comment> _parseComments(List<dynamic> commentList) {
    return commentList
        .map<Comment>((comment) {
          final int? id = int.tryParse(comment['id'].toString());
          return Comment(
            id: id ?? -1,
            content: comment['isDeleted'] == true
                ? "삭제된 댓글입니다."
                : comment['content'],
            author: comment['commenterName'] ?? '익명',
            date: comment['createdDate'] ?? '방금 전',
            likes: comment['likeCount'] ?? 0,
            isLiked: comment['isLiked'] ?? false,
            isAuthor: comment['isAuthor'] ?? false,
            replies: comment['children'] != null
                ? _parseComments(comment['children'])
                : [],
            isDeleted: comment['isDeleted'],
            commenterId: comment['commenterId'],
            commenterProfileImageUrl: comment['commenterProfileImageUrl'],
          );
        })
        .where((c) => c.id != -1)
        .toList();
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

    int postId = currentPostId.value;
    bool success;

    if (replyingToCommentId.value == -1) {
      // 일반 댓글 작성
      success = await remoteDataSource.addComment(postId, message);
    } else {
      // 답글 작성
      success = await remoteDataSource.addReply(
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

  /// 게시글 좋아요 여부
  RxBool isLikedPost = false.obs;

  /// 게시글 좋아요 토글
  void likePostToggle() {
    if (currentPostId.value == -1) {
      debugPrint("likePostToggle: currentPostId가 설정되지 않았습니다.");
      Get.snackbar("오류", "게시글 정보가 아직 준비되지 않았습니다.");
      return;
    }

    if (isLikedPost.value) {
      deleteLikedPost();
    } else {
      likePost();
    }
  }

  /// 게시글 좋아요 api 연동
  Future<void> likePost() async {
    final postIdRaw = currentPostId.value;

    final int postId = postIdRaw;

    bool success = await remoteDataSource.likePost(postId);
    if (success) {
      isLikedPost.value = true;
      fetchPostDetail(postId);
    } else {
      Get.snackbar("오류", "게시글 좋아요에 실패했습니다.");
    }
  }

  /// 게시글 좋아요 취소 api 연동
  Future<void> deleteLikedPost() async {
    int postId = currentPostId.value; // 현재 게시글 ID
    bool success = await remoteDataSource.deleteLikedPost(postId);

    if (success) {
      isLikedPost.value = false;
      fetchPostDetail(postId); // 게시글 상세 다시 불러오기 (새로고침)
    } else {
      Get.snackbar("오류", "게시글 좋아요 취소에 실패했습니다.");
    }
  }

  /// 게시글 스크랩 여부
  RxBool isScrappedPost = false.obs;

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
    int postId = currentPostId.value; // 현재 게시글 ID
    bool success = await remoteDataSource.scrapPost(postId);

    if (success) {
      isScrappedPost.value = true;
      fetchPostDetail(postId); // 게시글 상세 다시 불러오기 (새로고침)
    } else {
      Get.snackbar("오류", "게시글 스크랩에 실패했습니다.");
    }
  }

  /// 게시글 스크랩 취소 api 연동
  Future<void> deleteScrappedPost() async {
    int postId = currentPostId.value; // 현재 게시글 ID
    bool success = await remoteDataSource.deletePostScrap(postId);

    if (success) {
      isScrappedPost.value = false;
      fetchPostDetail(postId); // 게시글 상세 다시 불러오기 (새로고침)
    } else {
      Get.snackbar("오류", "게시글 스크랩 취소에 실패했습니다.");
    }
  }

  /// 댓글 좋아요 토글
  void likeCommentToggle(int commentId) {
    // 댓글 객체 찾기 (최상위 댓글 또는 대댓글)
    Comment? targetComment;

    for (var comment in comments) {
      if (comment.id == commentId) {
        targetComment = comment;
        break;
      }

      for (var reply in comment.replies) {
        if (reply.id == commentId) {
          targetComment = reply;
          break;
        }
      }

      if (targetComment != null) break;
    }

    if (targetComment == null) {
      debugPrint("댓글을 찾을 수 없습니다: $commentId");
      return;
    }

    if (targetComment.isLiked) {
      deleteLikedComment(commentId);
    } else {
      likeComment(commentId);
    }
  }

  void _updateCommentLikeState(int commentId, bool isLiked) {
    for (var comment in comments) {
      if (comment.id == commentId) {
        comment.isLiked = isLiked;
        comment.likes += isLiked ? 1 : -1;
        comments.refresh();
        return;
      }

      for (var reply in comment.replies) {
        if (reply.id == commentId) {
          reply.isLiked = isLiked;
          reply.likes += isLiked ? 1 : -1;
          comments.refresh();
          return;
        }
      }
    }

    debugPrint("댓글 ID $commentId 를 찾을 수 없습니다.");
  }

  /// 댓글 좋아요 api 연동
  Future<void> likeComment(int commentId) async {
    int postId = currentPostId.value;
    bool success = await remoteDataSource.likeComment(postId, commentId);

    if (success) {
      _updateCommentLikeState(commentId, true);
    } else {
      Get.snackbar("오류", "댓글 좋아요에 실패했습니다.");
    }
  }

  /// 댓글 좋아요 취소 api 연동
  Future<void> deleteLikedComment(int commentId) async {
    int postId = currentPostId.value;
    bool success = await remoteDataSource.deleteLikedComment(postId, commentId);

    if (success) {
      _updateCommentLikeState(commentId, false);
    } else {
      Get.snackbar("오류", "댓글 좋아요 취소에 실패했습니다.");
    }
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

    int postId = currentPostId.value;
    int commentId = editingCommentId.value;
    String updatedContent = messageController.text;

    bool success =
        await remoteDataSource.editComment(postId, commentId, updatedContent);

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
          commenterId: comments[index].commenterId,
          commenterProfileImageUrl: comments[index].commenterProfileImageUrl,
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

    int postId = currentPostId.value;
    int replyId = editingReplyId.value;
    String updatedContent = messageController.text;

    bool success =
        await remoteDataSource.editComment(postId, replyId, updatedContent);

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
            commenterId: comment.replies[replyIndex].commenterId,
            commenterProfileImageUrl:
                comment.replies[replyIndex].commenterProfileImageUrl,
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

  /// 게시물 삭제 기능
  Future<void> deletePost() async {
    int postId = currentPostId.value; // 현재 게시글 ID 가져오기
    bool success = await remoteDataSource.deletePost(postId);

    if (success) {
      Get.snackbar("삭제 성공", "게시물이 성공적으로 삭제되었습니다.");
      Get.offNamed('/community'); // 삭제 후 커뮤니티 화면으로 이동
    } else {
      Get.snackbar("삭제 실패", "게시물 삭제에 실패했습니다.");
    }
  }

  /// 댓글 또는 대댓글 삭제
  Future<void> deleteComment(int commentId) async {
    int postId = currentPostId.value; // 현재 게시글 ID 가져오기
    debugPrint("삭제 요청: postId = $postId, commentId = $commentId");

    bool success = await remoteDataSource.deleteComment(postId, commentId);

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

  /// 뒤로 가기
  void goBack() {
    Get.back();
  }

  /// 커뮤니티 화면 이동
  void goToCommunity() {
    Get.until((route) => Get.currentRoute == '/community');
  }

  /// 옵션 모달 토글
  void toggleModal() {
    isModalVisible.value = !isModalVisible.value;
  }

  /// 챗봇 화면 이동
  void toChatPage() {
    Get.toNamed('/chatbot');
  }

  /// 글쓰기 화면 이동
  void toNewPost() {
    Get.toNamed('/community/new_post');
  }
}
