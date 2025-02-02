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

        comments.value = _parseComments(
            postData['commentListResponse']['commentResponseList']);

        // 내가 작성한 게시글 ID 리스트 가져오기
        List<int> myPostIds = await RemoteDataSource.fetchMyPosts();
        debugPrint("내가 작성한 게시글 ID 리스트: $myPostIds"); // 로그 추가

        isAuthor.value = myPostIds.contains(postId);
        debugPrint("현재 게시글 ID: $postId, isAuthor: ${isAuthor.value}"); // 로그 추가
      }
    } catch (e) {
      debugPrint('게시글 상세 조회 중 오류 발생: $e');
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
        content: comment['content'],
        author: comment['author'] ?? '익명',
        date: comment['createdDate'] ?? '방금 전',
        likes: comment['likeCount'] ?? 0,
        isAuthor: comment['isAuthor'] ?? false,
        replies: comment['commentListResponse'] != null
            ? _parseComments(
                comment['commentListResponse']['commentResponseList'])
            : [],
      );
    }).toList();
  }

  /// 댓글 추가
  void addComment(String message) {
    if (message.isNotEmpty) {
      comments.add(
        Comment(
          content: message,
          author: '사용자',
          replies: [],
          date: '방금 전',
          likes: 0,
          isAuthor: true,
        ),
      );
    }
  }

  /// 댓글 입력값 변경 감지
  void updateMessage(String value) {
    messageText.value = value;
  }

  // /// 댓글 전송
  // void sendMessage() async {
  //   final message = messageController.text;
  //   if (message.isNotEmpty) {
  //     messageController.clear();
  //     addComment(message);
  //   }
  // }

  /// 댓글 추가 요청
  Future<void> sendMessage() async {
    String message = messageController.text;
    if (message.isEmpty) return;

    int postId = postDetail["id"]; // 현재 게시글 ID
    bool success = await RemoteDataSource.addComment(postId, message);

    if (success) {
      messageController.clear();
      messageText.value = '';
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
