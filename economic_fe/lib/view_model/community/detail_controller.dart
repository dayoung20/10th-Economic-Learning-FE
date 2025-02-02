import 'package:economic_fe/data/models/community/comment.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  RxBool isLoading = true.obs;
  RxMap<String, dynamic> postDetail = <String, dynamic>{}.obs;
  RxList<Comment> comments = RxList<Comment>();
  RxBool isAuthor = false.obs;
  RxList<int> myPostIds = <int>[].obs; // 내가 작성한 게시물 id
  RxList<int> likedPostIds = <int>[].obs; // 내가 좋아요 한 게시물 id
  RxList<int> scrappedPostIds = <int>[].obs; // 내가 스크랩 한 게시물 id
  RxMap<int, bool> likedCommentMap = <int, bool>{}.obs; // 각 댓글별 좋아요 상태

  final int currentUserId = 4; // 임시 유저 ID

  final TextEditingController messageController = TextEditingController();
  var messageText = ''.obs;
  RxBool isModalVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    int? postId = Get.arguments as int?;
    if (postId != null) {
      fetchPostDetail(postId);
    }
  }

  /// 게시글 상세 조회
  Future<void> fetchPostDetail(int postId) async {
    try {
      isLoading(true);
      final postData = await RemoteDataSource.getPostDetail(postId);

      if (postData != null) {
        postDetail.value = postData;

        await fetchLikedComments();
        comments.value = _parseComments(
            postData['commentListResponse']['commentResponseList']);

        await fetchMyPosts();
        isAuthor.value = myPostIds.contains(postId);

        await fetchLikedPosts();
        isLikedPost.value = likedPostIds.contains(postId);

        await fetchScrappedPosts();
        isScrappedPost.value = scrappedPostIds.contains(postId);
      }
    } catch (e) {
      print('게시글 상세 조회 중 오류 발생: $e');
    } finally {
      isLoading(false);
    }
  }

  /// 내가 작성한 게시글 조회
  Future<void> fetchMyPosts() async {
    myPostIds.value = await RemoteDataSource.fetchMyPosts();
  }

  /// 내가 좋아요 한 게시물 조회
  Future<void> fetchLikedPosts() async {
    final postLists = await RemoteDataSource.fetchLikedPosts();
    List<dynamic> posts = postLists['postList'];
    likedPostIds.value = posts.map<int>((post) => post['id']).toList();
    debugPrint("내가 좋아요한 게시글 ID 리스트: $likedPostIds"); // 로그 추가
  }

  /// 내가 스크랩 한 게시물 조회
  Future<void> fetchScrappedPosts() async {
    final postLists = await RemoteDataSource.fetchScrapedPosts();
    List<dynamic> posts = postLists['postList'];
    scrappedPostIds.value = posts.map<int>((post) => post['id']).toList();
    debugPrint("내가 스크랩한 게시글 ID 리스트: $scrappedPostIds"); // 로그 추가
  }

  /// 내가 좋아요 한 댓글 목록 조회
  Future<void> fetchLikedComments() async {
    try {
      final commentLists = await RemoteDataSource.fetchLikedComments();
      List<dynamic> likedComments = commentLists['likeCommentResponses'] ?? [];

      // 각 댓글별 좋아요 상태 저장
      likedCommentMap.value = {
        for (var comment in likedComments) comment['id']: true
      };

      debugPrint("내가 좋아요한 댓글 ID 리스트: ${likedCommentMap.keys.toList()}");
    } catch (e) {
      debugPrint("좋아요 한 댓글 목록 조회 중 오류 발생: $e");
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
        isAuthor:
            comment['commenterId'] == currentUserId, // 현재 사용자가 작성한 댓글인지 확인
        isLiked: likedCommentMap[comment['id']] ?? false, // 개별 댓글 좋아요 상태 반영
        replies: comment['children'] != null
            ? _parseComments(comment['children'])
            : [],
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

  /// 게시글 좋아요 여부
  RxBool isLikedPost = false.obs;

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

  /// 댓글 좋아요 토글
  void likeCommentToggle(int commentId) {
    if (likedCommentMap[commentId] == true) {
      deleteLikedComment(commentId);
    } else {
      likeComment(commentId);
    }
  }

  /// 댓글 좋아요 api 연동
  Future<void> likeComment(int commentId) async {
    int postId = postDetail["id"];
    bool success = await RemoteDataSource.likeComment(postId, commentId);

    if (success) {
      likedCommentMap[commentId] = true; // 해당 댓글만 좋아요 상태 변경
      fetchPostDetail(postId);
    } else {
      Get.snackbar("오류", "댓글 좋아요에 실패했습니다.");
    }
  }

  /// 댓글 좋아요 취소 api 연동
  Future<void> deleteLikedComment(int commentId) async {
    int postId = postDetail["id"];
    bool success = await RemoteDataSource.deleteLikedComment(postId, commentId);

    if (success) {
      likedCommentMap.remove(commentId); // 좋아요 취소 시 해당 댓글 ID 제거
      fetchPostDetail(postId);
    } else {
      Get.snackbar("오류", "댓글 좋아요 취소에 실패했습니다.");
    }
  }

  // 댓글 수정 상태 변수
  RxBool isEditingComment = false.obs;
  RxInt editingCommentId = (-1).obs;
  RxString editingCommentText = "".obs;

  /// 댓글 수정 모드 활성화
  void activateEditMode(int commentId, String content) {
    isEditingComment.value = true;
    editingCommentId.value = commentId;
    editingCommentText.value = content;
    messageController.text = content;
  }

  /// 댓글 수정 모드 해제
  void disableEditMode() {
    isEditingComment.value = false;
    editingCommentId.value = -1;
    editingCommentText.value = "";
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
        );
        comments.refresh();
      }
      disableEditMode();
    } else {
      Get.snackbar("오류", "댓글 수정에 실패했습니다.");
    }
  }

  /// 게시물 삭제 기능
  Future<void> deletePost() async {
    int postId = postDetail["id"]; // 현재 게시글 ID 가져오기
    bool success = await RemoteDataSource.deletePost(postId);

    if (success) {
      Get.snackbar("삭제 성공", "게시물이 성공적으로 삭제되었습니다.");
      Get.offNamed('/community'); // 삭제 후 커뮤니티 화면으로 이동
    } else {
      Get.snackbar("삭제 실패", "게시물 삭제에 실패했습니다.");
    }
  }

  /// 뒤로 가기
  void goBack() {
    Get.back();
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
