import 'package:economic_fe/data/models/community/comment.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  RxBool isLoading = true.obs;
  RxMap<String, dynamic> postDetail = <String, dynamic>{}.obs;
  RxList<Comment> comments = RxList<Comment>();
  RxBool isAuthor = false.obs;
  RxList<int> myPostIds = <int>[].obs;
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

  Future<void> fetchPostDetail(int postId) async {
    try {
      isLoading(true);
      final postData = await RemoteDataSource.getPostDetail(postId);

      if (postData != null) {
        postDetail.value = postData;
        comments.value = _parseComments(
            postData['commentListResponse']['commentResponseList']);

        await fetchMyPosts();
        isAuthor.value = myPostIds.contains(postId);
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
